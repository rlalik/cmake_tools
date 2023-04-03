# Collection of various cmake tools

## `find_or_fetch_package()`

Main task is to fetch external tool if one is not available in the system. It has three main modes:
* `FETCH` - force to fetch external tool
* `FIND` - force to use system tool
* `AUTO` - check the system, and if not available; default mode

### Usage

```cmake
include(find_or_fetch_package)

find_or_fetch_package(name url [VERSION version] [GIT_TAG optional_tag] [FETCH|FIND|AUTO] [EXPORT_OPTION])
```

* Find mode

  If `FIND` mode is selected, the `find_package(${name} ${VERSION} QUITE)` is called.

* Fetch mode

  If `FETCH` mode is selected, `FetchContent_Declare` will be called. If `GIT_TAG` is set, it will be used otherwise `VERSION` is use. If neither`GIT_TAG` or `VERSION` is provided, will result in fatal error in `FETCH|AUTO` mode.

* Auto mode

  It first try to find local installation (`FIND` mode) and if unsuccessful, call `FETCH` mode.


The `GIT_TAG` should be provied if the `VERSION` cannot be used as a tag name, or another branch or commit hash is required.

The macro will register option with name `${PROJECT_NAME}_BUILTIN_${upper_case_name}` (upper case of `name`) which can be controlled from command line, e.g.

If variable `USE_BUILTIN_xxx` (where `xxx` is the capitalized `name`) is set, it has priority over macro call modes. This variable should take value of the these three modes: `FETCH`, `FIND` or `AUTO`, e.g.:

`cmake -DUSE_BUILTIN_xxx=FETCH`

If `EXPORT_OPTION` is used it creates CACHE entry of `USE_BUILTIN_xxx`.


## shared_or_static()

### Syntax
```cmake
shared_or_static(name)
```

### Description

Creates variable `${name}_LIBRARY_TYPE` being either `STATIC` or `SHARED` which values depends on combination of `BUILD_SHARED_LIBS` and `${name}_BUILD_SHARED`.

* If neither of them is set, then `name_LIBRARY_TYPE` is undefined
* If only `BUILD_SHARED_LIBS` is set, `${name}_LIBRARY_TYPE = BUILD_SHARED_LIBS ? SHARED : STATIC`
* Otherwise `${name}_LIBRARY_TYPE = ${name}_BUILD_SHARED ? SHARED : STATIC`

### Usage

1. Build type controlled via options
```cmake
include(shared_or_static)

option(BUILD_SHARED_LIBS "Global option" OFF)
option(MyLibBuildType_BUILD_SHARED "Specific option" OFF)

shared_or_static(MyLibBuildType)

add_library(MyLib ${MyLibBuildType}_LIBRARY_TYPE source.cxx)
```
1. Build type hardcoded
```cmake
include(shared_or_static)

set(BUILD_SHARED_LIBS ON)
set(MyLibBuildType_BUILD_SHARED OFF)

shared_or_static(MyLibBuildType)

add_library(MyLib ${MyLibBuildType}_LIBRARY_TYPE source.cxx) # MyLib is STATIC
```
