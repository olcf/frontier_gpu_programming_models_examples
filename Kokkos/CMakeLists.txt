cmake_minimum_required (VERSION 3.10)
project (KokkosTutorial03)

#set(Kokkos_ROOT ${OLCF_KOKKOS_ROOT})

#include(../../common.cmake)

# if you're module loading the Kokkos module
#set(Kokkos_DIR "$ENV{OLCF_KOKKOS_ROOT}" CACHE STRING "Kokkos root directory")
#find_package(Kokkos REQUIRED)

# Doing an in tree build
add_subdirectory(/ccs/home/subil/learning/kokkos/kokkos  ./kokkos)

add_executable(03_Exercise exercise_3_begin.cpp)
target_link_libraries(03_Exercise Kokkos::kokkos)


