The vector addition example is obtained from [here](https://code.ornl.gov/olcf/vector_addition/-/tree/master/hip). 
The [vector addition repository](https://code.ornl.gov/olcf/vector_addition) contains examples 
of the same vector addition code written for different paradigms (HIP, OpenMP, MPI).

The hipblas example in the `hipblas_example` directory is adapted from [here](https://github.com/olcf/HIP_for_CUDA_programmers/tree/master/exercises/gpu_xgemm_test/solution).

Both examples have been modified to run with MPI. Each rank redundadntly performs the
same task and then uses `MPI_Reduce` to collect the maximum time spent on GPU and by the
rank among all the ranks.

## To build
You can build HIP code with either the CC compiler wrapper or with hipcc. 

NOTE: These are done on a new login session.

For make, run `CXX_COMPILER=<value> ./build_make.sh` where `<value>` is either
`CC` or `hipcc`. Look at the `build_make.sh`, `Makefile`, and `Makefile.hipcc` files to
understand what's going on. Within the `build_make.sh`, we are setting the `PrgEnv-cray`
for both `CC` and for `hipcc`, you can also use `PrgEnv-amd` for `CC` but not `PrgEnv-gnu`.
You can use `PrgEnv-amd` and `PrgEnv-gnu` for hipcc.
 
For cmake, run `./build_cmake.sh`. **CMake for HIP does not support changing compilers, it
will use the clang compiler provided in the ROCm installation.**
 Look at the `build_cmake.sh`, and `CMakeLists.txt` files to
understand what's going on. 

## Notes on CMake for HIP

CMake now supports HIP and compiling .hip files by setting `project(MyProj LANGUAGES HIP)`.
However, this supports only using the clang  provided in the ROCm library. Trying to set
a different HIP compiler with `-DCMAKE_HIP_COMPILER=CC` will fail because the `hip-lang-config.cmake`
tries searching for certain libraries relative to the compiler path and will fail for CC. So if 
you're using Cmake, assume you're going to be using the default ROCm clang compiler for all HIP
code.

If you want to be able to use CC as your compiler for HIP with Cmake, you will need to set 
`project(MyProj LANGUAGES CXX)`, use the .cpp extension for HIP files, and use the [legacy cmake
steps](https://rocm.docs.amd.com/en/latest/understand/cmake_packages.html#compiling-device-code-in-c-language-mode)

## General information 
For HIP, if you're compiling wit CC compiler wrapper with the Cray 
programming environment, make sure you load the following modules.

```
module load PrgEnv-cray 
module load craype-accel-amd-gfx90a
module load amd-mixed
```

For the AMD programming enviroment
```
module load PrgEnv-amd
module load craype-accel-amd-gfx90a
```

If you're using hipcc to compile, you don't need the `craype-accel-amd-gfx90a` module.

You can find more info about the necessary compiler flags for HIP compilation
[here](https://docs.olcf.ornl.gov/systems/frontier_user_guide.html#id9).


