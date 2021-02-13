cmake_minimum_required(VERSION 3.18)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules")
set(APP_BUILD_VERSION "0.0.1")
set(CMAKE_CXX_STANDARD 11)
# set(CMAKE_CXX_COMPILER "clang++") set(CMAKE_C_COMPILER "clang")

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
if(EXISTS ${PROJECT_SOURCE_DIR}/include/third_party)
  include_directories(${PROJECT_SOURCE_DIR}/include/third_party)
endif()

set(OPENSSL_USE_STATIC_LIBS ON)
find_package(Threads)
find_package(OpenSSL)

add_definitions(-DBUILD_VERSION="${APP_BUILD_VERSION}")
add_definitions(-DBUILD_ID="${GIT_COMMIT_HASH}")
add_definitions(-DBUILD_ARCH="${CMAKE_HOST_SYSTEM_PROCESSOR}")

aux_source_directory(src SRC_FILES)

add_executable(${PROJECT_NAME} ${SRC_FILES})

target_link_libraries(${PROJECT_NAME} Threads::Threads)
if(OPENSSL_FOUND)
  target_link_libraries(${PROJECT_NAME} OpenSSL::SSL OpenSSL::Crypto)
endif()
