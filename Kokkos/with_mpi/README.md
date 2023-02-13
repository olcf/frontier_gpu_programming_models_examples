This example in the subdirectories was adapted from Exercise 03 in the 
[kokkos-tutorials repo](https://github.com/kokkos/kokkos-tutorials).

It is the same as Exercise 03 with the surrounding the Kokkos parts with
`MPI_Init` and `MPI_Finalize` and doing `MPI_Reduce` to collect data across
all the ranks.
