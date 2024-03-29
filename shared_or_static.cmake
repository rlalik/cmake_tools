macro(shared_or_static name)

  if(NOT DEFINED BUILD_SHARED_LIBS AND NOT DEFINED ${name}_BUILD_SHARED)
    set(${name}_LIBRARY_TYPE "")
  elseif(NOT DEFINED ${name}_BUILD_SHARED)
    if(BUILD_SHARED_LIBS)
      set(${name}_LIBRARY_TYPE SHARED)
    else()
      set(${name}_LIBRARY_TYPE STATIC)
    endif()
  else()
    if(${name}_BUILD_SHARED)
      set(${name}_LIBRARY_TYPE SHARED)
    else()
      set(${name}_LIBRARY_TYPE STATIC)
    endif()
  endif()

endmacro()
