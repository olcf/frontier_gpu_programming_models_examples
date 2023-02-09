// Example from:  https://code.ornl.gov/olcf/vector_addition
// Written by: Tom Papatheodore

#include <stdio.h>
#include <iostream>
#include <iomanip>
#include <math.h>
#include <omp.h>

int main(int argc, char *argv[]){

    // Array length
    long long int N = 32*1024*1024;

    double tolerance = 1.0e-14;

    size_t buffer_size = N * sizeof(double);

    double *A = (double*)malloc(buffer_size);
    double *B = (double*)malloc(buffer_size);
    double *C = (double*)malloc(buffer_size);

    for(int i=0; i<N; i++){
        double random_value = (double)rand()/(double)RAND_MAX;
        A[i] = sin(random_value) * sin(random_value);
        B[i] = cos(random_value) * cos(random_value);
        C[i] = 0.0;
    }

    double start, end;
    start = omp_get_wtime();    

    #pragma omp target map(to:A[:N],B[:N]) map(tofrom:C[:N])
    {
    #pragma omp teams distribute parallel for simd
    for(int i=0; i<N; i++){
        C[i] = A[i] + B[i];
    } 
    }

    end = omp_get_wtime();
    double elapsed_time = end - start;

    double sum = 0.0;
    for(int i=0; i<N; i++){
        sum = sum + C[i];
    }

    double result = sum / (double)N;
    double relative_difference = fabs( (result - 1.0) / 1.0 );

    if(relative_difference > tolerance){
        printf("Test failed!\n");
    }
    else{
        printf("Test passed.\n");
    }

    printf("Result              = %.16f\n", result);
    printf("Relative difference = %.16f\n", relative_difference);
    printf("Tolerance           = %.16f\n", tolerance);
    printf("Array buffer size   = %zu\n", buffer_size);
    printf("Elapsed time (s)    = %.6f\n", elapsed_time);

    free(A);
    free(B);
    free(C);

    return 0;
}
