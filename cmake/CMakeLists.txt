cmake_minimum_required(VERSION 3.18)

option(BUILD_TESTING "Enables testing with Google Test." OFF)

set(APP_BUILD_VERSION "0.0.1")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 99)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_COMPILER "clang++")
set(CMAKE_C_COMPILER "clang")

set_property(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS ON)

set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
set(BUILD_SHARED_LIBS OFF)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -Wall -pedantic -Wextra")

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

if(NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type selected, default to Debug")
  set(CMAKE_BUILD_TYPE "Debug")
  set(CMAKE_CUDA_FLAGS_DEBUG "-g -G")
endif()

execute_process(
  COMMAND git log -1 --format=%h
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE GIT_COMMIT_HASH
  OUTPUT_STRIP_TRAILING_WHITESPACE)

project(
  App
  VERSION ${APP_BUILD_VERSION}
  LANGUAGES CXX C CUDA)

if(EXISTS ${PROJECT_SOURCE_DIR}/include)
  include_directories(${PROJECT_SOURCE_DIR}/include)
endif()

find_package(Threads)
set(OPENSSL_USE_STATIC_LIBS ON)
find_package(OpenSSL)
find_package(CUDAToolkit)
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost REQUIRED COMPONENTS filesystem atomic regex chrono)

add_definitions(-DBUILD_VERSION="${APP_BUILD_VERSION}")
add_definitions(-DBUILD_ID="${GIT_COMMIT_HASH}")
add_definitions(-DBUILD_ARCH="${CMAKE_HOST_SYSTEM_PROCESSOR}")

file(
  GLOB_RECURSE
  SRC_FILES
  CONFIGURE_DEPENDS
  "src/*.cpp"
  "src/*.c"
  "src/*.hpp"
  "src/*.h"
  "src/*.cuh"
  "src/*.cu")

if(EXISTS "${PROJECT_SOURCE_DIR}/src/main.cpp"
   OR EXISTS "${PROJECT_SOURCE_DIR}/src/main.c")
  # list(APPEND CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++")
  add_executable(${PROJECT_NAME} ${SRC_FILES})

  install(TARGETS ${PROJECT_NAME} DESTINATION bin)
else()
  add_library(${PROJECT_NAME} ${SRC_FILES})
  target_include_directories(${PROJECT_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/src)

  install(TARGETS ${PROJECT_NAME} DESTINATION lib)
endif()

if(BUILD_TESTING AND EXISTS "${CMAKE_SOURCE_DIR}/tests")
  add_subdirectory(tests)
  enable_testing()
  add_test(test_all tests/run_tests)
endif()

macro(SUBDIRLIST result curdir)
  file(
    GLOB children
    RELATIVE ${curdir}
    CONFIGURE_DEPENDS
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
  add_subdirectory(${CMAKE_SOURCE_DIR}/third_party/${SUB_DIR})
endforeach()

# cuda_driver cannot be statically linked
target_link_libraries(${PROJECT_NAME} Threads::Threads CUDA::cudart_static CUDA::cuda_driver)
if(OPENSSL_FOUND)
  target_link_libraries(${PROJECT_NAME} OpenSSL::SSL OpenSSL::Crypto)
endif()

if(Boost_FOUND)
  target_link_libraries(${PROJECT_NAME} Boost::filesystem Boost::atomic Boost::regex Boost::chrono)
endif()
