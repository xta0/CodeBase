project(recipe-01 LANGUAGES CXX)

# introduce a toggle for using a library
set(USE_LIBRARY OFF)

# BUILD_SHARED_LIBS is a global flag offered by CMake
# to toggle the behavior of add_library
set(BUILD_SHARED_LIBS OFF)

set (SRC message.cpp)
set (HDR message.h)

# list sources
list(APPEND _sources ${HDR} ${SRC})

if(USE_LIBRARY)
    # add_library will create a static library
    # as this is the default behavior of cmake
    # since BUILD_SHARED_LIBS is OFF
    add_library(message ${_sources})
    target_link_libraries(hello-world message)
else()
    add_executable(hello-world hello-world.cpp ${_sources})
endif()


