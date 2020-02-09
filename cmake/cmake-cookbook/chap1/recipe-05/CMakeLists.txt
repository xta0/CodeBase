project(recipe-05 LANGUAGES CXX)

# introduce a toggle for using a library
option(USE_LIBRARY "Compile sources into a library" OFF)

# mkdir -p build
# cd build
# cmake -D USE_LIBRARY=ON ..

# include a built-in module
include(CMakeDependentOption)

# second option depends on the value of the first
cmake_dependent_option(
  MAKE_STATIC_LIBRARY "Compile sources into a static library" OFF
  "USE_LIBRARY" ON
  )
# BUILD_SHARED_LIBS is a global flag offered by CMake
# to toggle the behavior of add_library
set(BUILD_SHARED_LIBS OFF)

set (SRC message.cpp)
set (HDR message.h)

# list sources
list(APPEND _sources ${HDR} ${SRC})

if(USE_LIBRARY)
    # add_library will create a static library
    # since BUILD_SHARED_LIBS is OFF
    add_library(message ${_sources})
    #craete the executable first
    add_executable(hello-world hello-world.cpp)
    # linke the dylib
    target_link_libraries(hello-world message)
else()
    add_executable(hello-world hello-world.cpp ${_sources})
endif()


