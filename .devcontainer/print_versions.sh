#!/usr/bin/env bash
set -euo pipefail
echo "== Tool versions =="
clang --version
echo "clang-tidy version: " && clang-tidy --version
clang-format --version
cmake --version
ninja --version
