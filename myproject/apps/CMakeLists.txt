add_executable(example_hello example_hello.cpp)
target_link_libraries(example_hello PRIVATE myproj::hello_lib)
