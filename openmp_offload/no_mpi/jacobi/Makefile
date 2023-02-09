COMP    = cc
FLAGS   = -fopenmp

jacobi: jacobi.o
	${COMP} ${FLAGS} jacobi.o -o jacobi

jacobi.o: jacobi.c
	${COMP} ${FLAGS} -c jacobi.c

.PHONY: clean

clean:
	rm -f jacobi *.o
