Here we have a `no_mpi` and `with_mpi` subdirectories. `no_mpi` has a single node example as well as 
Makefile and CMakeLists.txt examples for in-tree builds (where you keep a copy of Kokkos in your
project directory tree) and for module based builds (where you use the Kokkos module available
on Frontier by doing a module load). `with_mpi` has the same, but for an mpi+kokkos example.


## To Dos:
Create in tree (with make and cmake) and module build (with cmake) examples for no mpi, single node, example
Create an mpi+kokkos example
create in tree (with make and cmake) and module build (with cmake) examples for mpi+kokkos example
