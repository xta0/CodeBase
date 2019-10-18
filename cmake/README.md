## Useful CMake Commands

- `add_library`, command to generate libraries, the default output is a static library

    ```
    add_library(<name> [STATIC | SHARED | MODULE]
            [EXCLUDE_FROM_ALL]
            source1 [source2 ...])
    ```

- `target_include_directories`


### Resources

- [CMake Cookbook]()
- [Modern CMake](https://cliutils.gitlab.io/modern-cmake/modern-cmake.pdf)
- [Using Modern CMake Patterns to Enforce a Good Modular Design](https://www.youtube.com/watch?v=eC9-iRN2b04)
- [Effective CMake](https://www.youtube.com/watch?v=bsXLMQ6WgIk)
- [More Modern CMake](https://www.youtube.com/watch?v=y7ndUhdQuU8&feature=youtu.be)
- [How CMake is implemented](http://aosabook.org/en/cmake.html)