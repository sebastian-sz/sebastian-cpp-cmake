# .devcontainer/Dockerfile
FROM mcr.microsoft.com/devcontainers/base:debian-12

# ---- Configurable Clang toolchain version (e.g., 18/19/20/21) ----
ARG LLVM_VERSION=20
ENV DEBIAN_FRONTEND=noninteractive

# ---- Add apt.llvm.org (bookworm) and install toolchain + build utils ----
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    ca-certificates gnupg curl lsb-release software-properties-common; \
  mkdir -p /etc/apt/keyrings; \
  curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key \
    | gpg --dearmor -o /etc/apt/keyrings/apt.llvm.org.gpg; \
  echo "deb [signed-by=/etc/apt/keyrings/apt.llvm.org.gpg] http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-${LLVM_VERSION} main" \
    > /etc/apt/sources.list.d/llvm.list; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    clang-${LLVM_VERSION} \
    clang-tidy-${LLVM_VERSION} \
    clang-format-${LLVM_VERSION} \
    clangd-${LLVM_VERSION} \
    build-essential cmake ninja-build pkg-config git gdb; \
  rm -rf /var/lib/apt/lists/*

# ---- Make the chosen version the system default (explicit, no loops) ----
RUN set -eux; \
  update-alternatives --install /usr/bin/clang        clang        /usr/bin/clang-${LLVM_VERSION}        100; \
  update-alternatives --install /usr/bin/clang++      clang++      /usr/bin/clang++-${LLVM_VERSION}      100; \
  update-alternatives --install /usr/bin/clang-tidy   clang-tidy   /usr/bin/clang-tidy-${LLVM_VERSION}   100; \
  update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-${LLVM_VERSION} 100; \
  update-alternatives --install /usr/bin/clangd       clangd       /usr/bin/clangd-${LLVM_VERSION}       100

# ---- Sensible defaults for compilers (IDE-agnostic) ----
ENV CC=clang \
    CXX=clang++
