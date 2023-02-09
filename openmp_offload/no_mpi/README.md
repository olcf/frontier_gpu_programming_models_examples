We have two examples, a Vector add example [from the vector_addition example repo](https://code.ornl.gov/olcf/vector_addition) and a Jacobi example [from the openmp_offload repo](https://github.com/olcf/openmp-offload).

For OpenMP Offload, make sure that when you're compiling with CC you're module loading

```
module load craype-accel-amd-gfx90a
```


See also the [OpenMP Offload compiler flag documentation for Crusher](https://docs.olcf.ornl.gov/systems/crusher_quick_start_guide.html#openmp-gpu-offload).

And also see the OpenMP Offload tutorial series for more info about OpenMP Offload itself
(and also for Fortran examples):

https://github.com/olcf/openmp-offload
https://www.olcf.ornl.gov/calendar/introduction-to-openmp-offload-part-1/
https://www.olcf.ornl.gov/calendar/introduction-to-openmp-offload-part-2/
https://www.olcf.ornl.gov/calendar/preparing-for-frontier-openmp-part3/
