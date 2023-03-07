cmake_minimum_required(VERSION 3.16 FATAL_ERROR)
project(
  tools_tests
  VERSION 0.0.1
  LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/..)

message(STATUS "CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}")

include(find_or_fetch_package)

set(BUILD_SHARED_LIBS
    OFF
    CACHE INTERNAL "Build shared CPR")
set(CPR_FORCE_USE_SYSTEM_CURL ON)
set(CPR_USE_SYSTEM_GTEST ON)
find_or_fetch_package(cpr https://github.com/whoshuu/cpr GIT_TAG master AUTO EXPORT_OPTION)
