cmake_minimum_required(VERSION 3.5)
project(build_executable LANGUAGES CXX)

set(src "main.cpp")
set(VAR1 "var1" CACHE STRING "var1")
add_subdirectory(src)
message(STATUS, "ROOT: ${VAR1}")

add_executable(hello ${src})

