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

Creates dependent variable `name_BUILD_TYPE` being either `STATIC` or `SHARED`. If the global `BUILD_SHARED_LIBS` is set, then `name_BUILD_TYPE` is exposed to turn individual target into static. Provides also `${name}_STATIC`.

### Usage

```cmake
include(shared_or_static)

shared_or_sttaic(MyLibBuildType)

add_library(MyLib ${MyLibBuildType} source.cxx)
```
