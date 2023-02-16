cmake_minimum_required (VERSION 3.23)
project (kokkos_intree_cmake_example)


# Doing an in tree build
add_subdirectory(../../kokkos-3.6.00  ./kokkos)

add_executable(kokkos_example kokkos_example.cpp)
target_link_libraries(kokkos_example Kokkos::kokkos)


