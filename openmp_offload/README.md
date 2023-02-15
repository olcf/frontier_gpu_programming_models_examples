Here we have a `no_mpi` and `with_mpi` subdirectories. `no_mpi` has a single node example as well as 
Makefile and CMakeLists.txt examples for in-tree builds (where you keep a copy of Kokkos in your
project directory tree) and for module based builds (where you use the Kokkos module available
on Frontier by doing a module load). `with_mpi` has the same, but for an mpi+kokkos example.

Both directories uses the Jacobi example pulled from [here](https://github.com/olcf/openmp-offload/tree/master/C/6-openmp-combined). 

# Further learning resources

- Introduction to OpenMP Offload (tutorial from ORNL staff):
  - Part 1: https://www.olcf.ornl.gov/calendar/introduction-to-openmp-offload-part-1/
  - Part 2: https://www.olcf.ornl.gov/calendar/introduction-to-openmp-offload-part-2/
  - Part 3: https://www.olcf.ornl.gov/calendar/preparing-for-frontier-openmp-part3/
  - Examples: https://github.com/olcf/openmp-offload
