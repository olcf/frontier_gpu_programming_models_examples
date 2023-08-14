cmake_minimum_required(VERSION 3.23)

project(cpu_gpu_dgemm LANGUAGES HIP CXX)

# Find hipblas
find_package(hipblas REQUIRED)

# Find openblas
find_package(OpenBLAS REQUIRED)
include_directories(${OpenBLAS_INCLUDE_DIRS})

# Create the excutable
add_executable(cpu_gpu_dgemm cpu_gpu_dgemm.hip)


# Link with MPI
find_package(MPI)
if(MPI_CXX_FOUND)

 # Manually including additional flags needed for compiling MPI with the rocm clang compiler
 # these aren't included by the find_package(MPI) but are necessary for MPI on Frontier
 set(MPICH_GTL_DIR "$ENV{PE_MPICH_GTL_DIR_amd_gfx90a}")
 set(MPICH_GTL_LIBS "$ENV{PE_MPICH_GTL_LIBS_amd_gfx90a}")
 set(XPMEM_LIBS "$ENV{CRAY_XPMEM_POST_LINK_OPTS} -lxpmem")
 set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}  ${XPMEM_LIBS} ${MPICH_GTL_DIR} ${MPICH_GTL_LIBS}")

 target_link_libraries(cpu_gpu_dgemm MPI::MPI_CXX)
else()
 message("MPI_CXX_FOUND is false, so need to set MPI flags manually")
endif()

# Link with HIP and OpenBLAS
target_link_libraries(cpu_gpu_dgemm roc::hipblas ${OpenBLAS_LIBRARIES})
