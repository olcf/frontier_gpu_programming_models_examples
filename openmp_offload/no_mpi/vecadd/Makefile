COMP    = CC
FLAGS   = -fopenmp

vecadd: vecadd.o
	${COMP} ${FLAGS} vecadd.o -o vecadd

vecadd.o: vecadd.cpp
	${COMP} ${FLAGS} -c vecadd.cpp

.PHONY: clean

clean:
	rm -f vecadd *.o
