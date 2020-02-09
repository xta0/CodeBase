project(recipe-01 LANGUAGES CXX)

set (SRC message.cpp)
set (HDR message.h)
set (SRC1 Torch.cpp)
set (HDR1 Torch.h)

message(STATUS "project dir: ${PROJECT_SOURCE_DIR}")

#1. genreate a static library
add_library(message STATIC ${SRC} ${HDR})
add_library(torch STATIC ${SRC1} ${HDR1})

#2. generate executable binary
#the first hello-world is the target name
#the second hello-world is the source code to be compiled and linked
add_executable(hello-world hello-world.cpp)

#3. link the binary with the static lib 
#the first hello-world is the name of target
#the second message is the name of the static lib
target_link_libraries(hello-world PRIVATE message)
target_link_libraries(hello-world INTERFACE torch)



#To run the demo
# mkdir -p build
# cd build 
# cmake .. #this will generate a makefile
# cmake --build . #this will run the makefile

