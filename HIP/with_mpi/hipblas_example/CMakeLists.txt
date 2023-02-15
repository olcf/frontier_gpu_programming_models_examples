cmake_minimum_required(VERSION 3.23)

project(cpu_gpu_dgemm)

# Find hip
find_package(hip REQUIRED)
find_package(hipblas REQUIRED)

# Find openblas
find_package(OpenBLAS REQUIRED)
include_directories(${OpenBLAS_INCLUDE_DIRS})

# Create the excutable
add_executable(cpu_gpu_dgemm cpu_gpu_dgemm.cpp)

# Link with MPI
if("${CMAKE_CXX_COMPILER}" MATCHES "bin/hipcc")
 find_package(MPI)
 if(MPI_CXX_FOUND)
  message("MPI CXX Flags: ${MPI_CXX_LIBRARIES} ${MPI_CXX_INCLUDE_DIRS} ${MPI_CXX_LINK_FLAGS}")
  target_link_libraries(kokkos_example MPI::MPI_CXX)
 else()
  message("MPI_CXX_FOUND is false, so need to set MPI flags manually")
  set(MPICH_DIR "$ENV{MPICH_DIR}")

#  we've set the flags to variables manually in other mpi examples. Here I'm
#  also showing you the way to add the include and lib directories using the
#  more appropriate cmake target_* commands instead of using set.  
#  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I${MPICH_DIR}/include")
#  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L${MPICH_DIR}/lib -lmpi")
   target_include_directories(cpu_gpu_dgemm PUBLIC ${MPICH_DIR}/include)
   target_link_directories(cpu_gpu_dgemm PUBLIC ${MPICH_DIR}/lib)
   target_link_libraries(cpu_gpu_dgemm mpi)
 endif()
endif()	

# Link with HIP and OpenBLAS
target_link_libraries(cpu_gpu_dgemm hip::device roc::hipblas ${OpenBLAS_LIBRARIES})
