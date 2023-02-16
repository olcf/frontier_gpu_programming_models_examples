# Building your application with Kokkos in-tree
For in-tree builds, you maintain your own copy of the Kokkos source code as part
of your project directory. In this example, I'm maintaining Kokkos v3.6.0 source
code in the `../kokkos-v3.6.00` subdirectory. You can use CMake or make for in-tree builds
, Kokkos supports both (but CMake is preferred). 

The Kokkos source code is mostly header files protected by macros. The macros
ensure that it won't compile the entire Kokkos library, just the portions
determined by the your compile options (i.e. if you only specify the OpenMP
backend with the flags , it won't compile the HIP backend portions of the
code). This saves a lot of compilation time.

## Building with CMake
See the `CMakeLists.txt` for an example of how to set up for an in-tree build. Compile
by running `./build_cmake.sh`. Open `build_cmake.sh` and edit the variables at the top
for your desired compilation options.

If you're setting `CXX_COMPILER=CC` with `ENABLE_HIP=OFF`, you can use `PrgEnv-cray`, `PrgEnv-amd`,
`PrgEnv-gnu` interchangeably in the `./build_cmake.sh` file.

If you're setting `CXX_COMPILER=hipcc`, there's some additional things that
need to be considered when writing your `CMakeLists.txt`. `PrgEnv-amd` and
`PrgEnv-gnu` requires CMake compiler flags need to be explicitly set for MPI,
whereas with `PrgEnv-cray` CMake's `find_package(MPI)` can auto find and add
the appropriate libraries and flags.  See the `CMakeLists.txt` file for the
different actions that are taken based on which `PrgEnv` is being used. 

## Building with Make
See the `Makefile` for an example of how to set up a Makefile for an in-tree build.
Compile by running `./build_make.sh`. Open `build_make.sh` and edit the variables at the
top for your desired compilation options.

You can use `PrgEnv-cray`, `PrgEnv-amd`, `PrgEnv-gnu` interchangeably in the
`./build_make.sh` file for `hipcc`. No special considerations for MPI like in
CMake since we're explicitly setting the required MPI flags for all programming
environments.


## To run
See the `submit.sbatch` script.

## More information
There is more information about Kokkos compilation in the below links

* https://kokkos.github.io/kokkos-core-wiki/ProgrammingGuide/Compiling.html
* https://kokkos.github.io/kokkos-core-wiki/building.html 
