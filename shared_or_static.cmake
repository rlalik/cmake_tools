include(CMakeDependentOption)

macro(shared_or_static name)

  cmake_dependent_option(
    ${name}_STATIC # option variable
    "Build ${name} static library" # description
    ON # default value if exposed; user can override
    "NOT BUILD_SHARED_LIBS" # condition to expose option
    OFF # value if not exposed; user can't override
  )

  # set build type based on dependent option
  if(${name}_STATIC)
    set(${name}_BUILD_TYPE STATIC)
  else()
    set(${name}_BUILD_TYPE SHARED)
  endif()

endmacro()
