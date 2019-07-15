set(PARMETIS_NAME parmetis)
set(PARMETIS_URL ${PROJECT_SOURCE_DIR}/files)
set(PARMETIS_GZ  parmetis-4.0.3.tar.gz)
set(PARMETIS_MD5 "f69c479586bf6bb7aff6a9bc0c739628")

set(PATCH_COMMAND patch -p1 < ${PROJECT_SOURCE_DIR}/patches/parmetis-4.0.3-cmake.patch)
if(METIS_INT64)
  set(PATCH_COMMAND ${PATCH_COMMAND} COMMAND patch -p0 < ${PROJECT_SOURCE_DIR}/patches/metis-5.1.0-datatype.patch)
endif(METIS_INT64)


find_package(MPI REQUIRED)

message(STATUS "Building ${PARMETIS_NAME}")
ExternalProject_Add(${PARMETIS_NAME}
 URL ${PARMETIS_URL}/${PARMETIS_GZ}
 URL_MD5 ${PARMETIS_MD5}
 PREFIX ${PARMETIS_NAME}
 INSTALL_DIR install
 UPDATE_COMMAND ""
 PATCH_COMMAND ${PATCH_COMMAND}
 CMAKE_ARGS
   -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
   -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
   -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
   -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
   -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
   -DMPI_C_COMPILER:FILEPATH=${MPI_C_COMPILER}
   -DMPI_CXX_COMPILER:FILEPATH=${MPI_CXX_COMPILER}
   -DSHARED:BOOL=${BUILD_SHARED_LIBS}
   -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
   -DMETIS_INSTALL=ON
   -DGKLIB_PATH=<SOURCE_DIR>/metis/GKlib/
   -DMETIS_PATH=<SOURCE_DIR>/metis/
   -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
   LOG_BUILD 1
)
ExternalProject_get_property(${PARMETIS_NAME} INSTALL_DIR)
install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS)
