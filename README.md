# Collection of various cmake tools

## `check_3rd_party_tools()`

Main task is to fetch external tool if one is not available in the system. It has three main modes:
* `ON` - force to fetch external tool
* `OFF` - force to use system tool
* `AUTO` - check for system, and if not available, fetch; default mode

#### Usage

```cmake
include(check_3rd_party_tools)

check_3rd_party_tools(tool_name  desired_version  github_url [TAG optional_tag] [ON|OFF|AUTO])
```
The `optonal_tag` should be provied if the `version` cannot be used as a tag name, or another branch or commit hash is required.

The macro will register option with name `${PROJECT_NAME}_BUILTIN_${upper_case_name}` (upper case of `name`) which can be controlled from command line, e.g.

`cmake -Dmyproject_BUILTIN_TOOL=OFF`
