include(CheckIncludeFiles)

function(check_includes INCLUDES)
  set(INCLUDE_MISSING FALSE)
  foreach(INCLUDE_FILE ${INCLUDES})
    string(MAKE_C_IDENTIFIER "${INCLUDE_FILE}" c_include)
    check_include_files(${INCLUDE_FILE} ${c_include}_FOUND)
    set(${INCLUDE_FILE}_FOUND ${${c_include}_FOUND})
    if(NOT ${INCLUDE_FILE}_FOUND)
      set(INCLUDE_MISSING TRUE)
      set(MISSING_INCLUDES ${MISSING_INCLUDES} ${INCLUDE_FILE})
    else()
      # Auto '#cmakedefine' variable generation
      string(REPLACE "/" "_" INCLUDE_FILE_STR ${INCLUDE_FILE})
      string(REPLACE "." "_" INCLUDE_FILE_STR ${INCLUDE_FILE_STR})
      string(REPLACE "-" "_" INCLUDE_FILE_STR ${INCLUDE_FILE_STR})
      string(TOUPPER "LIZARDFS_HAVE_${INCLUDE_FILE_STR}" VAR)
      set(${VAR} TRUE PARENT_SCOPE)
    endif()
  endforeach()
  if(INCLUDE_MISSING)
    message("Some include files were not found: ${MISSING_INCLUDES}")
  endif()
endfunction()

