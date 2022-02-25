configure_file(CMakeLists.txt.in download/CMakeLists.txt)
execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/download)
if (result)
    message(FATAL_ERROR "CMake step for opencc failed: ${result}")
endif ()

execute_process(
        COMMAND ${CMAKE_COMMAND} --build .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/download)
if (result)
    message(FATAL_ERROR "Build step for opencc failed: ${result}")
endif ()

add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/src
        ${CMAKE_CURRENT_BINARY_DIR}/build EXCLUDE_FROM_ALL)

set(OPENCC_INCLUDE_DIR "${CMAKE_CURRENT_BINARY_DIR}/../../include")
add_custom_target(copy_libopencc_headers ALL DEPENDS libopencc)
add_custom_command(TARGET copy_libopencc_headers POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory
        "${OPENCC_INCLUDE_DIR}/opencc"
        COMMAND ${CMAKE_COMMAND} -E copy
        "${CMAKE_CURRENT_BINARY_DIR}/build/src/*.h"
        "${OPENCC_INCLUDE_DIR}/opencc"
        COMMAND ${CMAKE_COMMAND} -E copy
        "${CMAKE_CURRENT_BINARY_DIR}/src/src/*.hpp"
        "${OPENCC_INCLUDE_DIR}/opencc"
        )
add_dependencies(convert copy_libopencc_headers)

target_include_directories(convert PRIVATE ${OPENCC_INCLUDE_DIR})
