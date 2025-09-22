cmake_minimum_required(VERSION 3.25)

# --- options ---
option(MYPROJ_BUILD_EXAMPLES    "Build example applications"        ON)
option(MYPROJ_BUILD_TESTING     "Build tests"                       ON)
option(MYPROJ_USE_SYSTEM_GTEST  "Use system-installed GoogleTest"   OFF)

# --- project ---
project(
  MyProj
  VERSION       0.1.0
  DESCRIPTION   "An example CMake project"
  LANGUAGES     CXX
)

set(MYPROJ_VERSION        ${PROJECT_VERSION})
set(MYPROJ_SO_VERSION     1)

if(CMAKE_SOURCE_DIR STREQUAL PROJECT_SOURCE_DIR)
  set(CMAKE_CXX_STANDARD          17)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
  set(CMAKE_CXX_EXTENSIONS        OFF)
endif()

# --- common compiler warnings / build options (used by your helper) ---
add_library(myproj_common_compile_options INTERFACE)
add_library(myproj::common_compile_options ALIAS myproj_common_compile_options)
if(MSVC)
  target_compile_options(myproj_common_compile_options INTERFACE /W4)
else()
  target_compile_options(
    myproj_common_compile_options INTERFACE
    -Wall -Wextra -Wpedantic
  )
endif()

# --- testing dependencies ---
if(MYPROJ_BUILD_TESTING)
  include(CTest)

  if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    enable_testing()
  endif()

  if(MYPROJ_USE_SYSTEM_GTEST)
    find_package(GTest CONFIG REQUIRED)
    if(NOT TARGET GTest::gtest_main)
      message(FATAL_ERROR
        "MYPROJ_USE_SYSTEM_GTEST=ON requires a system GoogleTest that provides GTest::gtest_main")
    endif()
  else()
    include(FetchContent)
    FetchContent_Declare(
      googletest
      URL https://github.com/google/googletest/archive/refs/tags/v1.17.0.zip
    )
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)
  endif()
endif()

# --- libs/apps ---
add_subdirectory(myproject/libs)

if(MYPROJ_BUILD_EXAMPLES)
  add_subdirectory(myproject/apps)
endif()

# TODO: add install targets
