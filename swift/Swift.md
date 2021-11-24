## Swift History

Swift has released 15 versions since 2014, which includes five major versions and ten minor versions. In the contrast, Objective-C only has two versions since 1980s. Swift was officially open sourced in 2015, and gained the popularity in various of domains.

### Features

- 2014.8 (1.0) 
- 2015.9 (2.0)
    - Error handling 
    - `guard` syntax
    - protocol extension
- 2016.9 (3.0)
    - New GCD APIs (No C APIs)
    - New Core Graphics (No C APIs)
    - Remove `NS` prefix in foundation class
    - inline sequence function
    - `fileprivate` and `open`
    - remove `++` and `--`
- 2017.9 (4.0)
    - private access in extension
    - Combine class type and protocol using `&`
    - New Key Path syntax
    - Subscription supports generics
- 2019.3 (5.0)
    - ABI Stability
    - Raw strings
    - New `Result` type in foundation
    - Add interoperability with Python and Ruby 

### Compilation Process

1. Swift 
2. Swift-AST
3. Swift-IL
4. LLVM-IR
5 `.o`

### swiftc

- Executable `swiftc -o main.out main.swift`
- Swift AST `swiftc main.swift -dump-ast`
- Swift IR `swiftc main.swift -emit-sil`
- LLVM-IR `swiftc main.swift -emit-ir`
- Assembly Language `swiftc main.swift -emit-assembly`
