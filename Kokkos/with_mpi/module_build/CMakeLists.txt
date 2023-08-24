cmake_minimum_required (VERSION 3.23)
project (kokkos_example)

# if you're module loading the Kokkos module
set(Kokkos_DIR "$ENV{OLCF_KOKKOS_ROOT}" CACHE STRING "Kokkos root directory")
find_package(Kokkos REQUIRED)

add_executable(kokkos_example kokkos_example.cpp)

if("${CMAKE_CXX_COMPILER}" MATCHES "bin/hipcc")
 find_package(MPI)
 if(MPI_CXX_FOUND)
  message("MPI CXX Flags: ${MPI_CXX_LIBRARIES} ${MPI_CXX_INCLUDE_DIRS} ${MPI_CXX_LINK_FLAGS}")
 # Manually including additional flags needed for compiling MPI with the hipcc  compiler
 # these aren't included by the find_package(MPI)
 set(MPICH_GTL_DIR "$ENV{PE_MPICH_GTL_DIR_amd_gfx90a}")
 set(MPICH_GTL_LIBS "$ENV{PE_MPICH_GTL_LIBS_amd_gfx90a}")
 set(XPMEM_LIBS "$ENV{CRAY_XPMEM_POST_LINK_OPTS} -lxpmem")
 set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}  ${XPMEM_LIBS} ${MPICH_GTL_DIR} ${MPICH_GTL_LIBS}")
  target_link_libraries(kokkos_example MPI::MPI_CXX)
 else()
   message("MPI_CXX is not found by CMake. So need to set all the flags manually")
 endif()
endif()	

target_link_libraries(kokkos_example Kokkos::kokkos)
