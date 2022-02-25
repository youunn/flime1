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

set(OPENCC_HEADERS "${CMAKE_CURRENT_BINARY_DIR}/src/src" "${CMAKE_CURRENT_BINARY_DIR}/build/src")

target_include_directories(convert PRIVATE ${OPENCC_HEADERS})
