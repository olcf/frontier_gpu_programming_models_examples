cmake_minimum_required(VERSION 3.23)

project(vAdd_hip)

# Find hip
find_package(hip REQUIRED)

# Create the excutable
add_executable(vAdd_hip vAdd_hip.cpp)

# Link with MPI
if("${CMAKE_CXX_COMPILER}" MATCHES "bin/hipcc")
 find_package(MPI)
 if(MPI_CXX_FOUND)
  message("MPI CXX Flags: ${MPI_CXX_LIBRARIES} ${MPI_CXX_INCLUDE_DIRS} ${MPI_CXX_LINK_FLAGS}")
  target_link_libraries(kokkos_example MPI::MPI_CXX)
 else()
  message("MPI_CXX_FOUND is false, so need to set MPI flags manually")
  set(MPICH_DIR "$ENV{MPICH_DIR}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I${MPICH_DIR}/include")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L${MPICH_DIR}/lib -lmpi")
 endif()
endif()	

# Link with HIP
target_link_libraries(vAdd_hip hip::device)
