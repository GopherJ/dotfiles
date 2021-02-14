cmake_minimum_required(VERSION 3.18)

set(APP_BUILD_VERSION "0.0.1")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 99)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_COMPILER "clang++")
set(CMAKE_C_COMPILER "clang")

set_property(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS ON)

set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
set(BUILD_SHARED_LIBS OFF)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -std=c++11 -pedantic -Wextra")

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Weverything")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-c++98-compat")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-c++98-compat-pedantic")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-missing-noreturn")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-missing-prototypes")
  set(CMAKE_CXX_FLAGS
      "${CMAKE_CXX_FLAGS} -Wno-gnu-zero-variadic-macro-arguments")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
endif()

if(DEFINED ENV{VCPKG_ROOT} AND NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  set(CMAKE_TOOLCHAIN_FILE
      "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
      CACHE STRING "")
endif()

if(DEFINED ENV{VCPKG_DEFAULT_TRIPLET} AND NOT DEFINED VCPKG_TARGET_TRIPLET)
  set(VCPKG_TARGET_TRIPLET
      "$ENV{VCPKG_DEFAULT_TRIPLET}"
      CACHE STRING "")
endif()

if(NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type selected, default to Debug")
  set(CMAKE_BUILD_TYPE "Debug")
endif()

execute_process(
  COMMAND git log -1 --format=%h
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE GIT_COMMIT_HASH
  OUTPUT_STRIP_TRAILING_WHITESPACE)

project(Name)

if(EXISTS ${PROJECT_SOURCE_DIR}/include)
  include_directories(${PROJECT_SOURCE_DIR}/include)
endif()

set(OPENSSL_USE_STATIC_LIBS ON)
find_package(Threads)
find_package(OpenSSL)

add_definitions(-DBUILD_VERSION="${APP_BUILD_VERSION}")
add_definitions(-DBUILD_ID="${GIT_COMMIT_HASH}")
add_definitions(-DBUILD_ARCH="${CMAKE_HOST_SYSTEM_PROCESSOR}")

file(GLOB_RECURSE SRC_FILES "src/*.cpp" "src/*.c" "src/*.h")

if(EXISTS "${PROJECT_SOURCE_DIR}/src/main.cpp"
   OR EXISTS "${PROJECT_SOURCE_DIR}/src/main.c")
  add_executable(${PROJECT_NAME} ${SRC_FILES})
else()
  add_library(${PROJECT_NAME} ${SRC_FILES})
endif()

macro(SUBDIRLIST result curdir)
  file(
    GLOB children
    RELATIVE ${curdir}
    ${curdir}/*)
  set(dirlist "")
  foreach(child ${children})
    if(IS_DIRECTORY ${curdir}/${child})
      list(APPEND dirlist ${child})
    endif()
  endforeach()
  set(${result} ${dirlist})
endmacro()
subdirlist(SUB_DIRS ${CMAKE_SOURCE_DIR}/third_party)
foreach(SUB_DIR ${SUB_DIRS})
  add_subdirectory(${SUB_DIR})
endforeach()

if(EXISTS "${CMAKE_SOURCE_DIR}/tests")
  add_subdirectory(tests)
  enable_testing()
  add_test(test_all tests/run_tests)
endif()

target_link_libraries(${PROJECT_NAME} Threads::Threads)
if(OPENSSL_FOUND)
  target_link_libraries(${PROJECT_NAME} OpenSSL::SSL OpenSSL::Crypto)
endif()
