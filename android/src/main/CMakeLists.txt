cmake_minimum_required(VERSION 3.10)

project(fllama)

set(CMAKE_CXX_STANDARD 20)
set(FLLAMA_LIB_DIR ${CMAKE_SOURCE_DIR}/../../../ios/Cpp)

include_directories(${FLLAMA_LIB_DIR})

set(
        SOURCE_FILES
        ${FLLAMA_LIB_DIR}/ggml-alloc.c
        ${FLLAMA_LIB_DIR}/ggml-backend.cpp
        ${FLLAMA_LIB_DIR}/ggml-backend-reg.cpp
        ${FLLAMA_LIB_DIR}/ggml.c
        ${FLLAMA_LIB_DIR}/mmq.cpp
        ${FLLAMA_LIB_DIR}/amx.cpp
        ${FLLAMA_LIB_DIR}/ggml-cpu.c
        ${FLLAMA_LIB_DIR}/ggml-cpu.cpp
        ${FLLAMA_LIB_DIR}/ggml-cpu-quants.c
        ${FLLAMA_LIB_DIR}/ggml-threading.cpp
        ${FLLAMA_LIB_DIR}/ggml-cpu-aarch64.c
        ${FLLAMA_LIB_DIR}/ggml-quants.c
        ${FLLAMA_LIB_DIR}/common.cpp
        ${FLLAMA_LIB_DIR}/json.hpp
        ${FLLAMA_LIB_DIR}/json-schema-to-grammar.cpp
        ${FLLAMA_LIB_DIR}/sampling.cpp
        ${FLLAMA_LIB_DIR}/unicode-data.cpp
        ${FLLAMA_LIB_DIR}/unicode.cpp
        ${FLLAMA_LIB_DIR}/log.cpp
        ${FLLAMA_LIB_DIR}/llama.cpp
        ${FLLAMA_LIB_DIR}/llama-vocab.cpp
        ${FLLAMA_LIB_DIR}/llama-sampling.cpp
        ${FLLAMA_LIB_DIR}/sampling.cpp
        ${FLLAMA_LIB_DIR}/llama-grammar.cpp
        ${FLLAMA_LIB_DIR}/sgemm.cpp
        ${FLLAMA_LIB_DIR}/ggml-aarch64.c
        ${FLLAMA_LIB_DIR}/fllama.hpp
        ${FLLAMA_LIB_DIR}/stb_image.h
        ${FLLAMA_LIB_DIR}/base64.hpp
        ${FLLAMA_LIB_DIR}/clip.cpp
        ${FLLAMA_LIB_DIR}/clip.h
        ${FLLAMA_LIB_DIR}/llava.cpp
        ${FLLAMA_LIB_DIR}/llava.h
        ${FLLAMA_LIB_DIR}/fllava.hpp
        ${CMAKE_SOURCE_DIR}/utils.h
        ${CMAKE_SOURCE_DIR}/jni.cpp
)

find_library(LOG_LIB log)

function(build_library target_name cpu_flags)
    add_library(
            ${target_name}
            SHARED
            ${SOURCE_FILES}
    )
    add_compile_definitions(_GNU_SOURCE)
    target_compile_features(${target_name} PRIVATE cxx_std_20)
    target_compile_options(${target_name} PRIVATE -pthread ${cpu_flags})
    if (${ANDROID_ABI} STREQUAL "arm64-v8a")
        target_compile_options(${target_name} PRIVATE -mbranch-protection=standard -mno-unaligned-access)
    endif ()
    if (${ANDROID_ABI} STREQUAL "armeabi-v7a")
        target_compile_options(${target_name} PRIVATE -mfpu=neon-vfpv4)
    endif ()
    if (${CMAKE_BUILD_TYPE} STREQUAL "Debug")
        target_link_libraries(${target_name} ${LOG_LIB} android)
        add_definitions(-DLOGGING_ENABLED)
    endif ()

    # NOTE: If you want to debug the native code, you can uncomment if and endif
    # Note that it will be extremely slow
    # if (NOT ${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    target_compile_options(${target_name} PRIVATE -O3 -DNDEBUG)
    target_compile_options(${target_name} PRIVATE -fvisibility=hidden -fvisibility-inlines-hidden)
    target_compile_options(${target_name} PRIVATE -ffunction-sections -fdata-sections)
    target_compile_options(${target_name} PRIVATE -funroll-loops -fomit-frame-pointer)

    target_link_options(${target_name} PRIVATE -Wl,--gc-sections)
    target_link_options(${target_name} PRIVATE -Wl,--exclude-libs,ALL)
    target_link_options(${target_name} PRIVATE -Wl,-z,max-page-size=16384)
    target_link_options(${target_name} PRIVATE -flto)
    # endif ()
endfunction()

# Default target (no specific CPU features)
build_library("fllama" "")

if (${ANDROID_ABI} STREQUAL "arm64-v8a")
    # ARM64 targets
    build_library("fllama_v8_4_fp16_dotprod_i8mm" "-march=armv8.4-a+fp16+dotprod+i8mm")
    build_library("fllama_v8_4_fp16_dotprod" "-march=armv8.4-a+fp16+dotprod")
    build_library("fllama_v8_2_fp16_dotprod" "-march=armv8.2-a+fp16+dotprod")
    build_library("fllama_v8_2_fp16" "-march=armv8.2-a+fp16")
    build_library("fllama_v8" "-march=armv8.7-a")
elseif (${ANDROID_ABI} STREQUAL "x86_64")
    # x86_64 target
    build_library("fllama_x86_64" "-march=x86-64" "-mtune=intel" "-msse4.2" "-mpopcnt")
elseif (${ANDROID_ABI} STREQUAL "armeabi-v7a")
    # ARM32 target
    build_library("fllama_v7" "-march=armv7-a")
endif ()
