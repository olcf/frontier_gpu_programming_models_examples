cmake_minimum_required (VERSION 3.23)
project (kokkos_example)

# if you're module loading the Kokkos module
set(Kokkos_DIR "$ENV{OLCF_KOKKOS_ROOT}" CACHE STRING "Kokkos root directory")
find_package(Kokkos REQUIRED)

add_executable(kokkos_example kokkos_example.cpp)
target_link_libraries(kokkos_example Kokkos::kokkos)
