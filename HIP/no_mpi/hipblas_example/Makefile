COMP = CC

CFLAGS  = --rocm-path=${ROCM_PATH} -std=c++11 -D__HIP_ROCclr__ -D__HIP_ARCH_GFX90A__=1 --offload-arch=gfx90a -x hip
LFLAGS  = --rocm-path=${ROCM_PATH}

# including the OLCF_OPENBLAS_ROOT since we're requiring there is a cpu openblas piece in the file
INCLUDES  = -I${OLCF_OPENBLAS_ROOT}/include -I${OLCF_ROCM_ROOT}/include
LIBRARIES = -L${OLCF_OPENBLAS_ROOT}/lib -lopenblas  -L${ROCM_PATH}/lib -lhipblas -lamdhip64 


cpu_gpu_dgemm: cpu_gpu_dgemm.o
	${COMP} ${LFLAGS} ${LIBRARIES} cpu_gpu_dgemm.o -o cpu_gpu_dgemm

cpu_gpu_dgemm.o: cpu_gpu_dgemm.hip
	${COMP} ${CFLAGS} ${INCLUDES} -c cpu_gpu_dgemm.hip

.PHONY: clean

clean:
	rm -f cpu_gpu_dgemm *.o
