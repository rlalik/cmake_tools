include(FetchContent)

macro(check_3rd_party_tool name version url)
  set(options "")
  set(args TAG ON OFF AUTO)
  set(args_mult "")
  cmake_parse_arguments(ARG "${options}" "${args}" "${args_mult}" ${ARGN})

  string(TOUPPER ${name} upper_case_name)

  # git tag (branch, tag, etc) may be different than version name, even due to
  # semantics
  if(ARG_TAG)
    set(GIT_TAG ${ARG_TAG})
  else()
    set(GIT_TAG ${version})
  endif()

  if(ARG_ON)
    set(DEFAULT ON)
  elseif(ARG_OFF)
    set(DEFAULT OFF)
  else()
    set(DEFAULT AUTO)
  endif()

  set(${CMAKE_PROJECT_NAME}_BUILTIN_${upper_case_name}
      ${DEFAULT}
      CACHE STRING "Use built-in ${name}")
  set_property(CACHE ${CMAKE_PROJECT_NAME}_BUILTIN_${upper_case_name}
               PROPERTY STRINGS AUTO ON OFF)

  if(${CMAKE_PROJECT_NAME}_BUILTIN_${upper_case_name} STREQUAL "AUTO")
    find_package(${name} ${REQUIRED_${upper_case_name}_VERSION} QUIET)
    if(NOT ${name}_FOUND)
      set(USE_BUILTIN_${upper_case_name} TRUE)
    endif()
  elseif(${CMAKE_PROJECT_NAME}_BUILTIN_${upper_case_name}) # a true value (such
                                                           # as ON) was used
    set(USE_BUILTIN_${upper_case_name} TRUE)
  else() # a false value (such as OFF) was used
    find_package(${name} ${version} REQUIRED)
  endif()

  if(USE_BUILTIN_${upper_case_name})
    FetchContent_Declare(
      ${name}
      GIT_REPOSITORY ${url}
      GIT_TAG ${GIT_TAG})

    # FetchContent_MakeAvailable(${name})
    FetchContent_GetProperties(${name})
    if(NOT ${name}_POPULATED)
      FetchContent_Populate(${name})
      if(EXISTS "${${name}_SOURCE_DIR}"
         AND EXISTS "${${name}_SOURCE_DIR}/CMakeLists.txt")
        add_subdirectory(${${name}_SOURCE_DIR} ${${name}_BINARY_DIR})
      endif()
    endif()
  else()
    message(STATUS "Uses system-provided ${name}")
  endif()
endmacro()
