This Jacobi example is pulled from [here](https://github.com/olcf/openmp-offload/tree/master/C/6-openmp-combined). 

# To Build
To build with make, open the `build_make.sh` file and modify the `PRORGRAMMING_ENVIRONMENT` 
variable to your desired value and then run `./build_make.sh`. See the `Makefile.cray`
and `Makefile.amd` for examples of how to set up your Makefile.

To build with CMake, open the `build_cmake.sh` file and modify the `PRORGRAMMING_ENVIRONMENT` 
variable to your desired value and then run `./build_cmake.sh`. See the `CMakeLists.txt`
for an example of how to set it up for CMake.


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
