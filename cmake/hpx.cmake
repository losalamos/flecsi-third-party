set(HPX_NAME hpx)

message(STATUS "Building ${HPX_NAME}")
ExternalProject_Add(${HPX_NAME}
 SOURCE_DIR ${PROJECT_SOURCE_DIR}/hpx
 PREFIX ${HPX_NAME}
 INSTALL_DIR ${HPX_NAME}/install
 CONFIGURE_COMMAND ${CMAKE_COMMAND}
   -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
   -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
   -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
   -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
   -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
   -DCMAKE_SHARED_LINKER_FLAGS:STRING=${CMAKE_SHARED_LINKER_FLAGS}
   -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
   -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
   -DHPX_WITH_NETWORKING=OFF
   -DHPX_WITH_EXAMPLES=OFF
   -DHPX_WITH_TESTS=OFF
   -DHPX_WITH_MALLOC=system
   <SOURCE_DIR>
 INSTALL_COMMAND make install DESTDIR=<INSTALL_DIR>
)
ExternalProject_get_property(${HPX_NAME} INSTALL_DIR)
install(DIRECTORY ${INSTALL_DIR}/ ${CMAKE_INSTALL_PREFIX} DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS)
