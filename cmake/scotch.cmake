set(SCOTCH_NAME scotch)
set(SCOTCH_URL ${PROJECT_SOURCE_DIR}/files)
set(SCOTCH_GZ  scotch_6.0.4-cmake.tar.gz)
set(SCOTCH_MD5 "89e2f5a58fee907f42368d8c90c5a09e")


find_program(FLEX flex)
if (NOT FLEX)
   message( FATAL_ERROR
            "'flex' lexical parser not found. Cannot build scotch." )
endif()

#workaround for  StanfordLegion/legion#172
if(EXISTS "${CMAKE_INSTALL_PREFIX}/include/common.h")
  message(FATAL_ERROR "Cannot build scotch with Legion's common.h in ${CMAKE_INSTALL_PREFIX}/include (see  StanfordLegion/legion#172)")
endif()

message(STATUS "Building ${SCOTCH_NAME}")
ExternalProject_Add( ${SCOTCH_NAME}
 DEPENDS ${ZLIB_PACKAGE_NAME}

 URL ${SCOTCH_URL}/${SCOTCH_GZ}
 URL_MD5 ${SCOTCH_MD5}
 UPDATE_COMMAND ""
 CMAKE_ARGS
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
    -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DUSE_BZ2:BOOL=OFF
    -DBUILD_PTSCOTCH:BOOL=OFF
    -DZLIB_INCLUDE_DIR:PATH=${ZLIB_INCLUDE_DIR}
    -DZLIB_LIBRARY_RELEASE:PATH=${ZLIB_LIBRARIES}
    -DZLIB_LIBRARY_DEBUG:PATH=${ZLIB_LIBRARIES}
 LOG_BUILD 1
)
