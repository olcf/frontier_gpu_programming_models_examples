This Jacobi example is pulled from
[here](https://github.com/olcf/openmp-offload/tree/master/C/4-openmp-gpu-data)
with the modification that multiple ranks each redundantly perform the same set
of tasks (a cpu kernel and an offloaded kernel), and the max time among all the
ranks for each task is obtained with `MPI_Reduce`.

# To Build
For make, run `C_COMPILER=<value> ./build_make.sh` where `<value>` is either
`cc` or `hipcc`. Look at the `build_make.sh`, `Makefile`, and `Makefile.hipcc`
files to understand what's going on and how the flags are set. Within the
`build_make.sh`, we are setting the `PrgEnv-cray` for both `cc` and for
`hipcc`. 

For cmake, run `C_COMPILER=<value> ./build_cmake.sh` where `<value>` is either
`cc` or `hipcc`. Look at the `build_cmake.sh`, and `CMakeLists.txt` files to
understand what's going on. Within the `build_cmake.sh`, we are setting the `PrgEnv-cray`
for both `cc` and for `hipcc`.

You can use `PrgEnv-amd` instead of `PrgEnv-cray` as well in the build scripts
. It will compile the same way. `PrgEnv-gnu` won't work, see Notes section below.


# To run
See the `submit.sbatch` script.

# General information 
For OpenMP offload, if you're compiling wit cc compiler wrapper with the Cray or AMD
programming environment, make sure you load the following modules.

```
module load PrgEnv-cray # or amd
module load craype-accel-amd-gfx90a
module load rocm
```

If you're using hipcc directly, you only need

```
module load PrgEnv-Cray # or amd
module load rocm
```

See also the [OpenMP Offload compiler flag documentation for
Frontier](https://docs.olcf.ornl.gov/systems/frontier_user_guide.html#openmp-gpu-offload).

And also see the OpenMP Offload tutorial video series for more info about OpenMP Offload itself
(and also for Fortran examples):

- https://github.com/olcf/openmp-offload
- https://www.olcf.ornl.gov/calendar/introduction-to-openmp-offload-part-1/
- https://www.olcf.ornl.gov/calendar/introduction-to-openmp-offload-part-2/
- https://www.olcf.ornl.gov/calendar/preparing-for-frontier-openmp-part3/

Text tutorial if you don't want video: https://enccs.github.io/openmp-gpu/

# Notes
- GCC currently doesn't support offloading for MI250X accelerators yet. Only Cray
  and AMD support this at the moment. 
- Clang based compilers (Cray, AMD) don't support loop directives yet.
- When compiling with hipcc, you get "loop not vectorized" warnings from the
  LLVM optimizer by default. hipcc is a wrapper that adds a bunch of flags to
  the compile line, including -O3.  If you use -O3 with the cc wrapper from
  PrgEnv-amd, you'd get the same warnings (both hipcc and the cc wrapper call
  into the same underlying LLVM compiler from amd). You can see the full hipcc
  command by setting HIPCC_VERBOSE=7
  - cc from PrgEnv-cray gives similar (but not identical) warnings, since it
    uses a proprietary Cray optimizer in conjunction with upstream LLVM
    optimization passes.
- For hipcc, you need this part  "-fopenmp-targets=amdgcn-amd-amdhsa
  -Xopenmp-target=amdgcn-amd-amdhsa -march=gfx90a" to get  it to generate code
  for the GPU. If you omit this part, it will silently fallback to compiling for the CPU
  - The CC/cc  wrappers from the PrgEnv add these by default. hipcc needs the
    whole recipe, since it's really not "openmp aware", so it needs all the flags
    to control code generation to pass along to the underlying amdclang
  - The easiest way to check whether or not it's using the GPU is to run rocprof on
    the binary.  There's an environment variable OMP_TARGET_OFFLOAD=MANDATORY that
    should, when set, force the OpenMP runtime to abort if it cannot offload to the
    GPU. However between the way this is defined in the spec and the way
    implementations choose to do it,  it is not as reliable as it should be
    (implementation can and many do silently fall back to running the target region
    on the CPU).
- There seems to be a strange issue when you have a code (like our jacobi
  example) that uses math.h. If the `#include<math.h>` is declared before
  `#include<omp.h>` and then compiled with hipcc or the PrgEnv-amd cc, it seems
  to cause odd errors like `omp_is_initial_device` returning true when it should
  return false (thinking that there is no GPU). Putting the math.h declaration
  after the omp.h declaration solves this problem. AMD has been notified of the issue.
 
