cmake_minimum_required(VERSION 3.5)
project(static_libs LANGUAGES CXX)

# exec_program(/usr/bin/xcode-select ARGS -print-path OUTPUT_VARIABLE CMAKE_XCODE_DEVELOPER_DIR)


set(OSX_PLATFORM "MacOSX.platform")
exec_program(/usr/bin/xcode-select ARGS -print-path OUTPUT_VARIABLE CMAKE_XCODE_DEVELOPER_DIR)
set(XCODE_POST_43_ROOT "${CMAKE_XCODE_DEVELOPER_DIR}/Platforms/${OSX_PLATFORM}/Developer")
set(XCODE_PRE_43_ROOT "/Developer/Platforms/${OSX_PLATFORM}/Developer")
if(NOT DEFINED CMAKE_OSX_DEVELOPER_ROOT)
    if(EXISTS ${XCODE_POST_43_ROOT})
        set(CMAKE_OSX_DEVELOPER_ROOT ${XCODE_POST_43_ROOT})
    elseif(EXISTS ${XCODE_PRE_43_ROOT})
        set(CMAKE_OSX_DEVELOPER_ROOT ${XCODE_PRE_43_ROOT})
    endif(EXISTS ${XCODE_POST_43_ROOT})
endif(NOT DEFINED CMAKE_OSX_DEVELOPER_ROOT)
set(CMAKE_OSX_DEVELOPER_ROOT ${CMAKE_OSX_DEVELOPER_ROOT} CACHE PATH "Location of iOS Platform")

# Find and use the most recent iOS sdk unless specified manually with CMAKE_IOS_SDK_ROOT
if(NOT DEFINED CMAKE_OSX_SDK_ROOT)
    file(GLOB _CMAKE_OSX_SDKS "${CMAKE_OSX_DEVELOPER_ROOT}/SDKs/*")
    if(_CMAKE_OSX_SDKS) 
        list(SORT _CMAKE_OSX_SDKS)
        list(REVERSE _CMAKE_OSX_SDKS)
        list(GET _CMAKE_OSX_SDKS 0 CMAKE_OSX_SDK_ROOT)
        message(STATUS "_CMAKE_OSX_SDKS: ${_CMAKE_OSX_SDKS}")
    else(_CMAKE_OSX_SDKS)
        message(FATAL_ERROR "No OSX SDK's found in default search path ${CMAKE_OSX_DEVELOPER_ROOT}.")
    endif(_CMAKE_OSX_SDKS)
    message(STATUS "Toolchain using default OSX SDK: ${CMAKE_OSX_SDK_ROOT}")
endif(NOT DEFINED CMAKE_OSX_SDK_ROOT)
set(CMAKE_OSX_SDK_ROOT ${CMAKE_OSX_SDK_ROOT} CACHE PATH "Location of the selected OSX SDK")
# set up the default search directories for frameworks
set(CMAKE_SYSTEM_FRAMEWORK_PATH
    ${CMAKE_OSX_SDK_ROOT}/System/Library/Frameworks
    ${CMAKE_OSX_SDK_ROOT}/System/Library/PrivateFrameworks
    ${CMAKE_OSX_SDK_ROOT}/Developer/Library/Frameworks
)

set(CMAKE_FIND_FRAMEWORK FIRST)
set(LIBS Metal MetalPerformanceShaders)
find_library(METAL_PATH
NAMES ${LIBS}
PATHS ${CMAKE_SYSTEM_FRAMEWORK_PATH}
PATH_SUFFIXES Frameworks
NO_DEFAULT_PATH)

message(STATUS "METAL_PATH: ${METAL_PATH}")

# find_library(MPS_PATH
# NAMES MetalPerformanceShaders
# PATHS ${CMAKE_SYSTEM_FRAMEWORK_PATH}
# PATH_SUFFIXES Frameworks
# NO_DEFAULT_PATH)

# message(STATUS "MPS_PATH: ${MPS_PATH}")

# target_link_libraries()
