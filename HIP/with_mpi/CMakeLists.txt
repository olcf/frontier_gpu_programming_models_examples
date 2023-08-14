cmake_minimum_required(VERSION 3.23)

project(vAdd_hip LANGUAGES HIP CXX)


# Create the excutable
add_executable(vAdd_hip vAdd_hip.hip)

# Link with MPI
find_package(MPI)
if(MPI_CXX_FOUND)

 # Manually including additional flags needed for compiling MPI with the rocm clang compiler
 # these aren't included by the find_package(MPI)
 set(MPICH_GTL_DIR "$ENV{PE_MPICH_GTL_DIR_amd_gfx90a}")
 set(MPICH_GTL_LIBS "$ENV{PE_MPICH_GTL_LIBS_amd_gfx90a}")
 set(XPMEM_LIBS "$ENV{CRAY_XPMEM_POST_LINK_OPTS} -lxpmem")
 set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}  ${XPMEM_LIBS} ${MPICH_GTL_DIR} ${MPICH_GTL_LIBS}")

 target_link_libraries(vAdd_hip MPI::MPI_CXX)
else()
 message("MPI_CXX_FOUND is false, so need to set MPI flags manually")
endif()
