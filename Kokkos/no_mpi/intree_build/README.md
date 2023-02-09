# Building your application with Kokkos in-tree
For in-tree builds, you maintain your own copy of the Kokkos source code as part
of your project directory. In this example, I'm maintaining Kokkos v3.6.0 source
code in the `../kokkos-v3.6.00` subdirectory. You can use CMake or make for in-tree builds
, Kokkos supports both (but CMake is preferred). 

The Kokkos source code is mostly header files protected by macros. The macros ensure
that it won't compile the entire Kokkos library, just the portions determined by the 
your compile options (i.e. if you only specify the OpenMP backend, it won't compile
the HIP backend portions of the code). This saves a lot of compilation time.

## Building with CMake
See the `CMakeLists.txt` for an example of how to set up for an in-tree build. Compile
by running `./build_cmake.sh`. Open `build_cmake.sh` and edit the variables at the top
for your desired compilation options.

## Building with Make
See the `Makefile` for an example of how to set up a Makefile for an in-tree build.
Compile by running `./build_make.sh`. Open `build_make.sh` and edit the variables at the
top for your desired compilation options.

## To run
Run the compiled executable with `srun -N1 -n1 -G1 ./kokkos_example`.

## More information
There is more information about Kokkos compilation in the below links

* https://kokkos.github.io/kokkos-core-wiki/ProgrammingGuide/Compiling.html
* https://kokkos.github.io/kokkos-core-wiki/building.html 
