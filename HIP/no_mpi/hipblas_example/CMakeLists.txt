cmake_minimum_required(VERSION 3.23)

project(cpu_gpu_dgemm LANGUAGES HIP CXX)

find_package(hipblas REQUIRED)

# Find openblas
find_package(OpenBLAS REQUIRED)
include_directories(${OpenBLAS_INCLUDE_DIRS})

# Create the excutable
add_executable(cpu_gpu_dgemm cpu_gpu_dgemm.hip)

# Link with HIP
target_link_libraries(cpu_gpu_dgemm roc::hipblas ${OpenBLAS_LIBRARIES})
