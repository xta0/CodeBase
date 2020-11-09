cmake_minimum_required(VERSION 3.5)
project(static_libs LANGUAGES CXX)

set (src1 "src/Person.cpp")
set (hdr1 "src/Person.h")
set (src2 "src/Bar.cpp")
set (hdr2 "src/Bar.h")
set (src3 "src/Foo.cpp")
set (hdr3 "src/Foo.h")
set (src "src/main.cpp")

#1. genreate a static library
add_library(person STATIC ${src1} ${hdr1})
add_library(bar STATIC ${src2} ${hdr2})
add_library(foo STATIC ${src3} ${hdr3})
add_executable(app ${src})

#2. generate executable binary
target_link_libraries(person PRIVATE bar)
target_link_libraries(person INTERFACE foo)
target_link_libraries(app PUBLIC person)


#To run the demo
# mkdir -p build
# cd build 
# cmake .. #this will generate a makefile
# cmake --build . #this will run the makefile

