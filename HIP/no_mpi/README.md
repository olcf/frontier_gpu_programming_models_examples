This example is obtained from [here](https://code.ornl.gov/olcf/vector_addition/-/tree/master/hip). 
The [vector addition repository](https://code.ornl.gov/olcf/vector_addition) contains examples 
of the same vector addition code written for different paradigms (HIP, OpenMP, MPI).

## To build
You can build HIP code with either the CC compiler wrapper or with hipcc. 

For make, run `CXX_COMPILER=<value> ./build_make.sh` where `<value>` is either
`CC` or `hipcc`. Look at the `build_make.sh`, `Makefile`, and `Makefile.hipcc` files to
understand what's going on.

For cmake, run `CXX_COMPILER=<value> ./build_make.sh` where `<value>` is either
`CC` or `hipcc`. Look at the `build_cmake.sh`, and `CMakeLists.txt` files to
understand what's going on.


# General information 
For HIP, if you're compiling wit CC compiler wrapper with the Cray programming environment,
make sure you load the following modules.

```
module load PrgEnv-Cray
module load craype-accel-amd-gfx90a
module load rocm
```

If you're using hipcc, you only need

```
module load PrgEnv-Cray
module load rocm
```

You can find more info about the necessary compiler flags for HIP compilation [here](https://docs.olcf.ornl.gov/systems/frontier_user_guide.html#id6).


# Note
- Not setting `-DAMDGPU_TARGETS="gfx90a"` when running cmake (as you can see in `build_cmake.sh`
means that CMake will use the default `AMDGPU_TARGETS="gfx900;gfx906;gfx908;gfx90a;gfx1030"`. 
`gfx1030` is not supported by the Cray compiler.
