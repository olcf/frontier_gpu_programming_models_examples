COMP    = cc 
FLAGS   = -fopenmp -Wl,-rpath=$(GCC_PREFIX)/snos/lib64 -lm -foffload=default="-Ofast -lm -latomic -misa=gfx90a" 

jacobi: jacobi.c
	${COMP} ${FLAGS} jacobi.c -o jacobi


.PHONY: clean

clean:
	rm -f jacobi *.o
