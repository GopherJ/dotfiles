cmake_minimum_required(VERSION 3.18)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 99)

project(run_tests)

include(FetchContent)

set(gtest_force_shared_crt
    ON
    CACHE BOOL "" FORCE)

set(INSTALL_GTEST
    OFF
    CACHE BOOL "" FORCE)
set(INSTALL_GMOCK
    OFF
    CACHE BOOL "" FORCE)
set(BUILD_GMOCK
    OFF
    CACHE BOOL "" FORCE)

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG release-1.12.1
)

FetchContent_MakeAvailable(googletest)

include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

file(GLOB SRC_FILES "*.cpp" "*.c")

add_executable(${PROJECT_NAME} ${SRC_FILES})
target_link_libraries(${PROJECT_NAME} gtest gtest_main)
