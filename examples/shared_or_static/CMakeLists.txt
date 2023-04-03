project(SHARED_OR_STATIC_DEMO)
cmake_minimum_required(VERSION 3.0)

include(../../shared_or_static.cmake)

shared_or_static(DEMO)

message(STATUS "BUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}")
message(STATUS "DEMO_BUILD_SHARED=${DEMO_BUILD_SHARED}")
message(STATUS "DEMO_LIBRARY_TYPE=${DEMO_LIBRARY_TYPE}")
