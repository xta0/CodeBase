### BUILD Clang

1. Clone the repository. For now, let's use the most recent from llvm:

    ```
    > mkdir _llvm && cd _llvm
    > git clone https://github.com/llvm/llvm-project.git
```

2. Once that clones, create a separate build directory:
    
    ```
    > mkdir build-release && cd build-release
    ```

3. Configure llvm to build clang:

    ```
    > cmake -G Ninja ../llvm -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="lld; clang"
    ```
4. Run `ninja`