The vector addition example is obtained from [here](https://code.ornl.gov/olcf/vector_addition/-/tree/master/hip). 
The [vector addition repository](https://code.ornl.gov/olcf/vector_addition) contains examples 
of the same vector addition code written for different paradigms (HIP, OpenMP, MPI).

The hipblas example in the `hipblas_example` directory is adapted from [here](https://github.com/olcf/HIP_for_CUDA_programmers/tree/master/exercises/gpu_xgemm_test/solution).

In each example, each rank is redundantly performing the same task on GPU and
then `MPI_Reduce` is used to return the max time for GPU and/or MPI.

## To build
You can build HIP code with either the CC compiler wrapper or with hipcc. 

For make, run `CXX_COMPILER=<value> ./build_make.sh` where `<value>` is either
`CC` or `hipcc`. Look at the `build_make.sh`, `Makefile`, and `Makefile.hipcc` files to
understand what's going on. Within the `build_make.sh`, we are setting the `PrgEnv-cray`
for both `CC` and for `hipcc`, but the other PrgEnvs are also valid if you need to use 
those.

For cmake, run `CXX_COMPILER=<value> ./build_make.sh` where `<value>` is either
`CC` or `hipcc`. Look at the `build_cmake.sh`, and `CMakeLists.txt` files to
understand what's going on. Within the `build_cmake.sh`, we are setting the `PrgEnv-cray`
for both `CC` and for `hipcc`, but the other PrgEnvs are also valid if you need to use 
those.

## Notes on CMake for HIP

CMake support for HIP is still a work in progress. There are cmake files in
/opt/rocm-5.x.y that make those particular libraries available to CMake.  For
example, you can look in `/opt/rocm-5.1.0/lib/cmake` which contain directories
with the CMake config files. So in our example `CMakeLists.txt` we are doing a
`find_package(hipblas)` and a `target_link_libraries(blah roc::hipblas)`. You
can see that there are `hipblas-*.cmake` files in
`/opt/rocm-5.1.0/lib/cmake/hipblas` and there is a `add_library(roc::hipblas
SHARED IMPORTED)` in `hipblas-targets.cmake` which makes that hipblas library
available as `roc::hipblas` for use in CMake when compiling your HIP files.
This is similar for other hiplibraries like hipfft (`hip:hipfft`) and hiprand
(`hip::hiprand`). So you might be doing a little scavenger hunting to figure
out the directives to use for a particular hip library. 

I would highly recommend watching Balint Joo's talk that covers more detail: 


## General information 
For HIP, if you're compiling wit CC compiler wrapper with the Cray or AMD
programming environment, make sure you load the following modules.

```
module load PrgEnv-cray # or amd
module load craype-accel-amd-gfx90a
module load rocm
```

If you're using hipcc, you only need

```
module load PrgEnv-Cray
module load rocm
```

You can find more info about the necessary compiler flags for HIP compilation
[here](https://docs.olcf.ornl.gov/systems/frontier_user_guide.html#id6).


# Note
- Not setting `-DAMDGPU_TARGETS="gfx90a"` when running cmake (as you can see in `build_cmake.sh`
means that CMake will use the default `AMDGPU_TARGETS="gfx900;gfx906;gfx908;gfx90a;gfx1030"`. 
`gfx1030` is not supported by the Cray compiler.
