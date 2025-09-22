# sebastian-cpp-cmake
Starter template for modern C++ with CMake, Ninja, Docker, and GoogleTest

This is my 2nd iteration and it's quite far from done. I'd still like to tweak a few things but the core structure is there.

# Quickstart
Build the project:
```bash
cmake --preset=debug && cmake --build --preset=debug
```
or simply `make`.

Running tests:
```bash
ctest --preset=debug
```
or simply `make test`

Cleaning up:
```bash
rm -rf build
```
or simply `make clean`


# Toolchain provided by docker container
The docker / devcontainer is a bliss for managing the toolchain. It also integrates nicely with VSCode. Can also be built standalone for CI or other IDEs.

# CMake best practices
By far the trickiest part. There is massive amount of resources for CMake and also massive amount of CMake code. Yet it's difficult to separate signal from noise. What I have here feels OK-ish. The library and test declarations do feel verbose, but I left them as is for better future flexibility.

# Planned enhancements:
* clang-tidy and clang-format only on files that diff from main branch.
* `make install` support
* `ccache` integration

# Some observations
During writing this repository I went on to read about CMake for a couple of days and here are guidelines that could be making sense:

## The toolchain should rely on Docker container, but should not enforce it.
E.g. it could speed up onboarding (just launch devcontainer), but the user should be free to install the necessary components system wide.
I think it's a good practice for a Docker container to be available.

## Separation of concerns
In an ideal world the Docker would be solely responsible for providing the toolchain (compiler, linker etc) and CMake / package manager for providing (most of) the packages.

However some packages are just too heavy to build locally (Opencv, Boost etc.). These should be placed in Docker container. The fast to compile deps should be fetched via CMake or package manager, not to clutter the image too much.

## When developing an app, package managers are safe
Given that we are the end consumer of our work it could be safe (or even beneficial) to integrate a package manager like `vcpkg` or `Conan`. When placed in Docker container it should pose minimal development friction.

## When developing a library, be mindful of dependencies.
If we don't know who the end users of our code are we should be a bit more vigilant. We shouldn't force the consumers to rely on `vcpkg` just because we rely on it. The good rule of thumb is to try to stay in the CMake land as much as possible.
