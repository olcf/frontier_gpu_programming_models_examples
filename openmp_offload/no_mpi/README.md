This Jacobi example is pulled from [here](https://github.com/olcf/openmp-offload/tree/master/C/6-openmp-combined). 

# To Build
To build with make, run `PROGRAMMING_ENVIRONMENT=<value> ./build_make.sh` where `<value>`
is `cray` or `amd` depending on the programming environment you want.  See the `Makefile`
for an example of how to set it up.

To build with cmake, run `PROGRAMMING_ENVIRONMENT=<value> ./build_cmake.sh` where `<value>`
is `cray` or `amd` depending on the programming environment you want.  See the `CMakeLists.txt`
for an example of how to set it up.



# General information
For OpenMP Offload, make sure that when you're compiling with PrgEnv-cray you're module loading

```
module load PrgEnv-Cray
module load craype-accel-amd-gfx90a
module load rocm
```

And if you're compiling with PrgEnv-amd, your're module loading

```
module load PrgEnv-amd
module load craype-accel-amd-gfx90a
module load rocm
```


See also the [OpenMP Offload compiler flag documentation for Frontier](https://docs.olcf.ornl.gov/systems/frontier_user_guide.html#openmp-gpu-offload).

And also see the OpenMP Offload tutorial series for more info about OpenMP Offload itself
(and also for Fortran examples):

- https://github.com/olcf/openmp-offload
- https://www.olcf.ornl.gov/calendar/introduction-to-openmp-offload-part-1/
- https://www.olcf.ornl.gov/calendar/introduction-to-openmp-offload-part-2/
- https://www.olcf.ornl.gov/calendar/preparing-for-frontier-openmp-part3/

# Notes
- GCC currently doesn't support offloading for MI250X accelerators yet. So only Cray
  and AMD support this at the moment.
- Clang based compilers (Cray, AMD) don't support loop directives yet.
- When compiling with hipcc, you get "loop not vectorized" warnings from the
  LLVM optimizer by default. hipcc is a wrapper that adds a bunch of flags to
  the compile line, including -O3.  If you use -O3 with the cc wrapper from
  PrgEnv-amd, you'd get the same warnings (both hipcc and the cc wrapper call
  into the same underlying LLVM compiler from amd). You can see the full hipcc
  command by setting HIPCC_VERBOSE=7
  - cc from PrgEnv-cray gives similar (but not identical) warnings, since it
    uses a proprietary Cray optimizer in conjunction with   upstream LLVM
    optimization passes.

