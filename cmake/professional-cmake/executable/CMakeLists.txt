cmake_minimum_required(VERSION 3.5)
project(build_executable LANGUAGES CXX)

set(src "main.cpp" "src/person.h")

add_executable(hello ${src})

