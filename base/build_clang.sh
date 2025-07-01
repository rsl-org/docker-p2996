#!/bin/sh
cmake -G Ninja -S clang-p2996/llvm -B build \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" \
    -DLLVM_ENABLE_RUNTIMES="libunwind;libcxx;libcxxabi" \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_BUILD_TESTS=OFF \
    -DCMAKE_INSTALL_PREFIX="data/usr" \
    -DCMAKE_INSTALL_RPATH="$ORIGIN/../lib;$ORIGIN/../lib64" \
    -DLLVM_RUNTIME_TARGETS="x86_64-unknown-linux-gnu" \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    -DCLANG_DEFAULT_CXX_STDLIB=libc++

ninja -C build
ninja -C build install
