COMP  = hipcc
FLAGS = --amdgpu-target=gfx90a

INCLUDES  = 
LIBRARIES =  

vAdd_hip: vAdd_hip.o
	${COMP} ${FLAGS} ${LIBRARIES} vAdd_hip.o -o vAdd_hip

vAdd_hip.o: vAdd_hip.cpp
	${COMP} ${FLAGS} ${INCLUDES} -c vAdd_hip.cpp

.PHONY: clean

clean:
	rm -f vAdd_hip *.o
