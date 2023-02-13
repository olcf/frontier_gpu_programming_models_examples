cmake_minimum_required (VERSION 3.23)
project (kokkos_example)

# if you're module loading the Kokkos module
set(Kokkos_DIR "$ENV{OLCF_KOKKOS_ROOT}" CACHE STRING "Kokkos root directory")
find_package(Kokkos REQUIRED)

add_executable(kokkos_example kokkos_example.cpp)

if("${CMAKE_CXX_COMPILER}" MATCHES "bin/hipcc")
 find_package(MPI)
 if(MPI_CXX_FOUND)
  # MPI_CXX_FOUND is true for PrgEnv-cray, so we can do a target_link_libraries which will
  # take care of setting the appropriate MPI flags when the compiler is invoked
  message("MPI CXX Flags: ${MPI_CXX_LIBRARIES} ${MPI_CXX_INCLUDE_DIRS} ${MPI_CXX_LINK_FLAGS}")
  target_link_libraries(kokkos_example MPI::MPI_CXX)
 else()
  # MPI_CXX_FOUND is false for PrgEnv-amd, so we need to explicitly set MPI flags for hipcc
  message("MPI_CXX_FOUND is false, so need to set MPI flags manually")
  set(MPICH_DIR "$ENV{MPICH_DIR}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I${MPICH_DIR}/include")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L${MPICH_DIR}/lib -lmpi")
 endif()
endif()	


target_link_libraries(kokkos_example Kokkos::kokkos)
