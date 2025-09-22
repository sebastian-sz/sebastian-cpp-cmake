# --- myproj::hello_lib ---
add_library(
  myproj_hello_lib
  src/hello.cpp
)
add_library(myproj::hello_lib ALIAS myproj_hello_lib)
target_sources(myproj_hello_lib
  PUBLIC
    FILE_SET HEADERS
    BASE_DIRS include
    FILES include/myproj/hello.hpp
)
target_include_directories(
  myproj_hello_lib
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
target_link_libraries(myproj_hello_lib
  PRIVATE
    myproj::common_compile_options
)
target_compile_features(myproj_hello_lib PUBLIC cxx_std_17)
set_target_properties(myproj_hello_lib PROPERTIES
  VERSION           ${MYPROJ_VERSION}
  SOVERSION         ${MYPROJ_SO_VERSION}
  EXPORT_NAME       hello_lib
)

# --- (tests) myproj::hello_lib_test ---
if (MYPROJ_BUILD_TESTING)
  add_executable(
    myproj_hello_lib_tests
    tests/test_hello.cpp
  )
  add_executable(myproj::hello_lib_tests ALIAS myproj_hello_lib_tests)
  target_link_libraries(myproj_hello_lib_tests
    PRIVATE
      myproj::hello_lib
      GTest::gtest_main
  )
  target_compile_features(myproj_hello_lib_tests PRIVATE cxx_std_17)

  include(GoogleTest)
  gtest_discover_tests(myproj_hello_lib_tests)
endif()