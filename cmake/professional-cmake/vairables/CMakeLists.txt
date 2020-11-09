cmake_minimum_required(VERSION 3.5)
project(build_executable LANGUAGES CXX)

set(src "main.cpp")
# set(ROOT "ROOT")
# set(ROOT-CACHED "ROOT-CACHED" CACHE STRING "")
# set(VAR1 "var1" CACHE STRING "")
# add_subdirectory(src1)
# add_subdirectory(src2)
# message(STATUS "[ROOT] ROOT: ${ROOT}")
# message(STATUS "[ROOT] ROOT-CACHED: ${ROOT-CACHED}")
# message(STATUS "[ROOT] SRC1: ${SRC1}")
# message(STATUS "[ROOT] SRC2: ${SRC2}")
# message(STATUS "[ROOT] SRC1-CACHED: ${SRC1-CACHED}")
# message(STATUS "[ROOT] SRC2-CACHED: ${SRC2-CACHED}")


set(myVar foo) # Local myVar
set(result ${myVar}) # result = foo
set(myVar bar CACHE STRING "") # Cache myVar
set(result ${myVar}) # First run: result = bar
# Subsequent runs: result = foo
message(STATUS ${result})



add_executable(hello ${src})