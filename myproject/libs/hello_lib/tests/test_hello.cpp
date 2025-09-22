#include <gtest/gtest.h>

#include "myproj/hello.hpp"

TEST(HelloTest, BasicAssertions) { EXPECT_EQ(hello(), "Hello, from CMake!"); }
