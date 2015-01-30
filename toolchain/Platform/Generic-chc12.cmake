#
# Generic Tool chain support.
#

MESSAGE ("Loaded: Generic-chc12.cmake")

GET_FILENAME_COMPONENT(CHC12_PATH ${CMAKE_C_COMPILER} PATH)

IF(NOT DEFINED CHC12_PIPER)
    SET(CHC12_PIPER ${CHC12_PATH}/piper)
ENDIF()

IF(NOT DEFINED CHC12_BURNER)
    SET(CHC12_BURNER ${CHC12_PATH}/burner.exe)
ENDIF()

SET(CMAKE_OBJCOPY      FALSE)
SET(CMAKE_OBJDUMP      FALSE)

#
# We have to setup the object type very early, as this can't be overridden later on.
#
SET (CMAKE_C_OUTPUT_EXTENSION     ".o"         CACHE STRING "C compiler object extension.")
SET (CMAKE_CXX_OUTPUT_EXTENSION   ".o"         CACHE STRING "C++ compiler object extension.")

#
# Convince CMake we know our compiler works OK.
# If we don't do this it will do a TRY-COMPILE which will fail to link.
#
SET (CMAKE_C_COMPILER_ID_RUN    TRUE)
SET (CMAKE_C_COMPILER_WORKS     TRUE)
SET (CMAKE_CXX_COMPILER_ID_RUN  TRUE)
SET (CMAKE_CXX_COMPILER_WORKS   TRUE)

SET (CMAKE_C_COMPILER_ID        chc12)
SET (CMAKE_CXX_COMPILER_ID      chc12)

#
# Don't generate preprocessed or assembler makefile rules for C/C++ source files.
#
SET (CMAKE_SKIP_PREPROCESSED_SOURCE_RULES    TRUE)
SET (CMAKE_SKIP_ASSEMBLY_SOURCE_RULES        TRUE)

#
# Workaround to inhibit CMake from performing a TRY-COMPILE to determine the size of "void *",
# this size isn't ever used so its actual value doesn't matter.
#
SET (CMAKE_SIZEOF_VOID_P 2)

#
# Library and linker extensions. (Object extensions have to be specified earlier in Toolchain-Freescale-HC12.cmake)
#
SET (CMAKE_FIND_LIBRARY_PREFIXES                     "")
SET (CMAKE_FIND_LIBRARY_SUFFIXES                     ".lib")
SET (CMAKE_STATIC_LIBRARY_PREFIX                     "")
SET (CMAKE_STATIC_LIBRARY_SUFFIX                     ".lib")
SET (CMAKE_LINK_LIBRARY_SUFFIX                        ".lib")
SET (CMAKE_EXECUTABLE_SUFFIX                         ".elf")

#
# C compiler.
#
SET (CMAKE_C_FLAGS_INIT                             "${CMAKE_C_FLAGS_INIT} -ViewHidden -Cc -NoEnv -NoBeep -WOutFileOn -WmsgNu=abcde")
SET (CMAKE_C_FLAGS_DEBUG_INIT                       "${CMAKE_C_FLAGS_DEBUG_INIT}")
SET (CMAKE_C_FLAGS_MINSIZEREL_INIT                  "${CMAKE_C_FLAGS_MINSIZEREL_INIT}")
SET (CMAKE_C_FLAGS_RELEASE_INIT                     "${CMAKE_C_FLAGS_RELEASE_INIT}")
SET (CMAKE_C_FLAGS_RELWITHDEBINFO_INIT              "${CMAKE_C_FLAGS_RELWITHDEBINFO_INIT}")
SET (CMAKE_C_STANDARD_LIBRARIES_INIT                "${CMAKE_C_STANDARD_LIBRARIES_INIT}")

#
# C++ compiler
#
SET (CMAKE_CXX_FLAGS_INIT                           "${CMAKE_CXX_FLAGS_INIT} -ViewHidden -Cc -NoEnv -NoBeep -WOutFileOn -WmsgNu=abcde")
SET (CMAKE_CXX_FLAGS_DEBUG_INIT                     "${CMAKE_CXX_FLAGS_DEBUG_INIT}")
SET (CMAKE_CXX_FLAGS_MINSIZEREL_INIT                "${CMAKE_CXX_FLAGS_MINSIZEREL_INIT}")
SET (CMAKE_CXX_FLAGS_RELEASE_INIT                   "${CMAKE_CXX_FLAGS_RELEASE_INIT}")
SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT            "${CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT}")
SET (CMAKE_CXX_STANDARD_LIBRARIES_INIT              "${CMAKE_CXX_STANDARD_LIBRARIES_INIT}")

#
# Flags used by the linker.
#
SET (CMAKE_EXE_LINKER_FLAGS_INIT                    "${CMAKE_EXE_LINKER_FLAGS_INIT} -ViewHidden -NoBeep -WErrFileOn -WmsgNu=abe")
SET (CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT              "${CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT}")
SET (CMAKE_EXE_LINKER_FLAGS_MINSIZEREL_INIT         "${CMAKE_EXE_LINKER_FLAGS_MINSIZEREL_INIT}")
SET (CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT            "${CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT}")
SET (CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO          "${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO}")

SET (CMAKE_MODULE_LINKER_FLAGS_INIT                 "${CMAKE_MODULE_LINKER_FLAGS_INIT}")
SET (CMAKE_MODULE_LINKER_FLAGS_DEBUG_INIT           "${CMAKE_MODULE_LINKER_FLAGS_DEBUG_INIT}")
SET (CMAKE_MODULE_LINKER_FLAGS_MINSIZEREL_INIT      "${CMAKE_MODULE_LINKER_FLAGS_MINSIZEREL_INIT}")
SET (CMAKE_MODULE_LINKER_FLAGS_RELEASE_INIT         "${CMAKE_MODULE_LINKER_FLAGS_RELEASE_INIT}")
SET (CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO_INIT  "${CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO_INIT}")

SET (CMAKE_SHARED_LINKER_FLAGS_INIT                 "${CMAKE_SHARED_LINKER_FLAGS_INIT}")
SET (CMAKE_SHARED_LINKER_FLAGS_DEBUG_INIT           "${CMAKE_SHARED_LINKER_FLAGS_DEBUG_INIT}")
SET (CMAKE_SHARED_LINKER_FLAGS_MINSIZEREL_INIT      "${CMAKE_SHARED_LINKER_FLAGS_MINSIZEREL_INIT}")
SET (CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT         "${CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT}")
SET (CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO_INIT  "${CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO_INIT}")

#
# Compiler invocation.
#
SET (CMAKE_C_COMPILE_OBJECT              "${CHC12_PIPER} ${CMAKE_C_COMPILER} <DEFINES> <FLAGS> -ObjN=<OBJECT> -EnvERRORFILE=${HC12_ERR_OUTPUT_DIR}/%n.err -Lasm=${HC12_LST_OUTPUT_DIR}/%n.lst <SOURCE>")
SET (CMAKE_CXX_COMPILE_OBJECT            "${CHC12_PIPER} ${CMAKE_CXX_COMPILER} <DEFINES> <FLAGS> -ObjN=<OBJECT> -EnvERRORFILE=${HC12_ERR_OUTPUT_DIR}/%n.err -Lasm=${HC12_LST_OUTPUT_DIR}/%n.lst <SOURCE>")

#
# Librarian invocation.
#
SET (CMAKE_C_CREATE_STATIC_LIBRARY       "${CHC12_PIPER} ${CMAKE_AR} -ViewHidden -WmsgNu=abcde -NoBeep -WOutFileOn -EnvERRORFILE=${HC12_ERR_OUTPUT_DIR}/%n_lib.err -Mar{<TARGET> <OBJECTS>}")
SET (CMAKE_CXX_CREATE_STATIC_LIBRARY     "${CMAKE_C_CREATE_STATIC_LIBRARY}")

#
# Link support.
#
SET (CMAKE_LIBRARY_PATH_FLAG "-L")
SET (CMAKE_LINK_LIBRARY_FLAG "-Add")

#
# Link invocation.
#
SET (CMAKE_C_LINK_EXECUTABLE "${CHC12_PIPER} <CMAKE_LINKER> -Add{<OBJECTS>} <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <LINK_LIBRARIES> -O<TARGET> -EnvERRORFILE=${HC12_ERR_OUTPUT_DIR}/link.err ${HC12_LINK_PRM_FILE}")

#
# Create custom output directories.
#
FILE (MAKE_DIRECTORY ${HC12_LST_OUTPUT_DIR})
FILE (MAKE_DIRECTORY ${HC12_ERR_OUTPUT_DIR})
