COMP = CC

CFLAGS  = --rocm-path=${ROCM_PATH} -std=c++11 -D__HIP_ROCclr__ -D__HIP_ARCH_GFX90A__=1 --offload-arch=gfx90a -x hip
LFLAGS =  --rocm-path=${ROCM_PATH}

INCLUDES  =
LIBRARIES = -L${ROCM_PATH}/lib -lamdhip64


vAdd_hip: vAdd_hip.o
	${COMP} ${LFLAGS} ${LIBRARIES} vAdd_hip.o -o vAdd_hip

vAdd_hip.o: vAdd_hip.cpp
	${COMP} ${CFLAGS} ${INCLUDES} -c vAdd_hip.cpp

.PHONY: clean

clean:
	rm -f vAdd_hip *.o
