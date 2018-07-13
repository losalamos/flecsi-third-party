set(CINCH_UTILS_NAME cinch-utils)

message(STATUS "Building ${CINCH_UTILS_NAME}")
ExternalProject_Add(${CINCH_UTILS_NAME}
 DEPENDS ${GASNET_NAME}
 SOURCE_DIR ${PROJECT_SOURCE_DIR}/cinch-utils
 PREFIX third-party
 INSTALL_DIR third-party/install
 CONFIGURE_COMMAND ${CMAKE_COMMAND}
   -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
   -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
   -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
   -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
   -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
   -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
   -ENABLE_DOCUMENTATION=ON
   <SOURCE_DIR>
   LOG_BUILD 1
)
ExternalProject_get_property(${CINCH_UTILS_NAME} INSTALL_DIR)
install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS)
