cmake_minimum_required(VERSION 3.22.1)
project(rkllm_jni LANGUAGES CXX)

add_library(rkllmrt SHARED IMPORTED)
set_target_properties(rkllmrt PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/librkllmrt.so")

add_library(omp_runtime SHARED IMPORTED)
set_target_properties(omp_runtime PROPERTIES
    IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/libomp.so")

add_library(rkllm_jni SHARED rkllm_jni.cpp)
target_compile_features(rkllm_jni PRIVATE cxx_std_17)
target_include_directories(rkllm_jni PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_compile_options(rkllm_jni PRIVATE -Wall -Wextra -Werror)

find_library(log-lib log)
target_link_libraries(rkllm_jni PRIVATE rkllmrt omp_runtime ${log-lib})
