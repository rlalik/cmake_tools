cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(
  tools_tests
  VERSION 0.0.1
  LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/..)

message(STATUS "CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}")

include(check_3rd_party_tool)

set(BUILD_SHARED_LIBS
    OFF
    CACHE INTERNAL "Build shared CPR")
set(CPR_FORCE_USE_SYSTEM_CURL ON)
set(CPR_USE_SYSTEM_GTEST ON)
check_3rd_party_tool(cpr 1.7.2 https://github.com/whoshuu/cpr TAG 1.7.2)
