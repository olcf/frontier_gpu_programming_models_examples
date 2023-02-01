# Building your application with the Frontier Kokkos module

The Frontier's Kokkos module (obtained with `module load kokkos`) was  built
with `hipcc`. You can check all the options that Kokkos was built with (and thus
supports for your application build) by executing `module show kokkos`. 


## Building with CMake
See the `CMakeLists.txt` for an example of how to set up for an in-tree build. Compile
by running `./build_cmake.sh`. Open `build_cmake.sh` and edit the variables at the top
for your desired compilation options.


## Note
Instead of using the precompiled module, you can also use a precompiled
Kokkos that you built from source in a similar way. You can do this by
navigating to your Kokkos source directory and running the following steps
(just as an example):

```
mkdir build && cd build
# show build with hipcc
cmake .. -DCMAKE_CXX_COMPILER=hipcc \
 -DCMAKE_INSTALL_PREFIX=${my_install_folder}

export CMAKE_PREFIX_PATH=/path/to/built/kokkos
```

And then in your project's own `CMakeLists.txt
