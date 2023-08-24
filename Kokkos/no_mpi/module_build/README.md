# Building your application with the Frontier Kokkos module

The Frontier's Kokkos module (obtained with `module load kokkos`) was  built
with `hipcc`. You can check all the options that Kokkos was built with (and thus
supports for your application build) by executing `module show kokkos`. 


## Building with CMake
See the `CMakeLists.txt` for an example of how to set up for a system module
based build.  Compile by running `./build_cmake.sh`. Open `build_cmake.sh` to
see the build command. 

You should be able to use `PrgEnv-cray`, `PrgEnv-amd`, `PrgEnv-gnu`
interchangeably since it depends only on `hipcc`.


## To run
See the `submit.sbatch` script.


## Note
Instead of using the precompiled module from Frontier, you can also use a precompiled
Kokkos that you built from source in a similar way. You can do this by
navigating to your Kokkos source directory and running the following steps
(just as an example):

```
mkdir build && cd build
module load PrgEnv-cray
module load amd-mixed 
module load cmake/3.23.2

export MY_INSTALL_FOLDER=/path/to/install/location

cmake .. -DCMAKE_CXX_COMPILER=hipcc \
 -DCMAKE_INSTALL_PREFIX=${MY_INSTALL_FOLDER}} \
 -DKokkos_ARCH_VEGA90A=ON \
 -DKokkos_ARCH_ZEN3=ON \
 -DKokkos_ENABLE_HIP=ON \
 -DKokkos_ENABLE_SERIAL=ON 

make VERBOSE=1

export CMAKE_PREFIX_PATH=${MY_INSTALL_FOLDER}:${CMAKE_PREFIX_PATH}
```

And then in your project's own `CMakeLists.txt`, make it something like the 
`CMakeLists.txt` in this directory, but making sure you update the `Kokkos_DIR`

```
set(Kokkos_DIR "$ENV{MY_INSTALL_FOLDER}" CACHE STRING "Kokkos root directory")
```

### generate_makefile.bash

You can also use the
`[generate_makefile.bash](https://github.com/kokkos/kokkos/blob/master/generate_makefile.bash)
script to generate the appropriate cmake flags and execute cmake to create the
makefile that cmake would generate (and then run `make` to build Kokkos). This is an alternative to calling cmake with the correct flags yourself. This is suited for building Kokkos that you can link to later, not for an intree build. Run `generate_makefile.bash --help` to see
all the options.
