set(EXODUS_NAME exodus)
set(EXODUS_URL ${PROJECT_SOURCE_DIR}/files)
set(EXODUS_GZ  exodus-6.09.tar.gz)
set(EXODUS_MD5 "2c139fc98706a04778d5607ab80b5d4d")

ExternalProject_get_property(${NETCDF_NAME} INSTALL_DIR)
set(NETCDF_INSTALL_DIR ${INSTALL_DIR})

message(STATUS "Building ${EXODUS_NAME}")
ExternalProject_Add(${EXODUS_NAME}
 DEPENDS ${NETCDF_NAME}
 URL ${EXODUS_URL}/${EXODUS_GZ}
 URL_MD5 ${EXODUS_MD5}
 UPDATE_COMMAND ""
 PATCH_COMMAND patch -p0 < ${PROJECT_SOURCE_DIR}/patches/exodus.patch
 PREFIX ${EXODUS_NAME}
 INSTALL_DIR install
 CONFIGURE_COMMAND ${CMAKE_COMMAND}
   -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
   -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
   -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
   -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
   -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
   -DCMAKE_Fortran_COMPILER:FILEPATH=${CMAKE_Fortran_COMPILER}
   -DCMAKE_Fortran_FLAGS:STRING=${CMAKE_Fortran_FLAGS}
   -DBUILD_SHARED:BOOL=${BUILD_SHARED_LIBS}
   -DBUILD_TESTING:BOOL=OFF
   -DNETCDF_NCDUMP:PATH=${NETCDF_INSTALL_DIR}/bin/ncdump
   -DNETCDF_SO_ROOT:PATH=${NETCDF_INSTALL_DIR}/lib/shared
   -DNETCDF_INCLUDE_DIR:PATH=${NETCDF_INSTALL_DIR}/include
   -DNETCDF_LIBRARY:PATH=${NETCDF_LIBRARIES}
   -DHDF5HL_LIBRARY:PATH=${HDF5_HL_LIBRARIES}
   -DHDF5_LIBRARY:PATH=${HDF5_LIBRARIES}
   -DSZIP_LIBRARY:PATH=${SZIP_LIBRARIES}
   -DZLIB_LIBRARY=${ZLIB_LIBRARIES}
   -DPYTHON_INSTALL:PATH=<INSTALL_DIR>/python
   -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
   <SOURCE_DIR>/exodus
   LOG_BUILD 1
)
ExternalProject_get_property(${EXODUS_NAME} INSTALL_DIR)
install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS)
