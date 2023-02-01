# Building your application with the Frontier Kokkos module

The Frontier's Kokkos module (obtained with `module load kokkos`) was  built
with `hipcc`. You can check all the options that Kokkos was built with (and thus
supports for your application build) by executing `module show kokkos`. 


## Building with CMake
See the `CMakeLists.txt` for an example of how to set up for a system module based build.
Compile by running `./build_cmake.sh`. Open `build_cmake.sh` and edit the variables at
the top for your desired compilation options.


## Note
Instead of using the precompiled module from Frontier, you can also use a precompiled
Kokkos that you built from source in a similar way. You can do this by
navigating to your Kokkos source directory and running the following steps
(just as an example):

```
mkdir build && cd build
module load PrgEnv-cray
module load rocm

export MY_INSTALL_FOLDER=/path/to/install/location

# show build with hipcc
cmake .. -DCMAKE_CXX_COMPILER=hipcc \
 -DCMAKE_INSTALL_PREFIX=${MY_INSTALL_FOLDER}} \
 -DKokkos_ARCH_VEGA90A=ON \
 -DKokkos_ARCH_ZEN3=ON \
 -DKokkos_ENABLE_HIP=ON \
 -DKokkos_ENABLE_SERIAL=ON 

make VERBOSE=1

export CMAKE_PREFIX_PATH=${MY_INSTALL_FOLDER}:${CMAKE_PREFIX_PATH}
```

And then in your project's own `CMakeLists.txt` you write something like
```
cmake_minimum_required (VERSION 3.10)
project (kokkos_example)

# if you're module loading the Kokkos module
set(Kokkos_DIR "$ENV{MY_INSTALL_FOLDER}" CACHE STRING "Kokkos root directory")
find_package(Kokkos REQUIRED)

add_executable(kokkos_example kokkos_example.cpp)
target_link_libraries(kokkos_example Kokkos::kokkos)
```


