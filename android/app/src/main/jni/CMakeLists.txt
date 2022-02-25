cmake_minimum_required(VERSION 3.10)

project(convert)

add_library(convert SHARED native_convert.cpp)
target_include_directories(convert PUBLIC ${CMAKE_SOURCE_DIR})

add_subdirectory(thirdparty)

# TODO: 有空再改
if (NOT ${CMAKE_HOST_SYSTEM_NAME} MATCHES "Windows")
    add_dependencies(convert Dictionaries)
endif ()

target_link_libraries(convert libopencc log)

# NOTE: windows不能直接运行编译的opencc_dict，要自己复制opencc的data到assets
if (NOT ${CMAKE_HOST_SYSTEM_NAME} MATCHES "Windows")
    add_custom_command(TARGET convert POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E make_directory
            ${CMAKE_SOURCE_DIR}/../../../../../assets/opencc
            COMMAND ${CMAKE_COMMAND} -E copy
            ${CMAKE_BINARY_DIR}/thirdparty/src/opencc/build/data/*.ocd2
            ${CMAKE_SOURCE_DIR}/../../../../../assets/opencc
            COMMAND ${CMAKE_COMMAND} -E copy
            ${CMAKE_BINARY_DIR}/thirdparty/src/opencc/build/data/*.txt
            ${CMAKE_SOURCE_DIR}/../../../../../assets/opencc
            COMMAND ${CMAKE_COMMAND} -E copy
            ${CMAKE_BINARY_DIR}/thirdparty/src/opencc/src/data/config/*.json
            ${CMAKE_SOURCE_DIR}/../../../../../assets/opencc
            )
endif ()
