/*------------------------------------------------------------------------------------------------
This program will fill 2 NxN matrices with random numbers, compute a matrix multiply on the CPU 
and then on the GPU, compare the values for correctness, and print _SUCCESS_ (if successful).

Written by Tom Papatheodore
------------------------------------------------------------------------------------------------*/

#include <stdio.h>
#include <cblas.h>
#include <hipblas.h>
#include <mpi.h>

// Macro for checking errors in CUDA API calls
#define gpuErrorCheck(call)                                                              \
do{                                                                                       \
    hipError_t gpuErr = call;                                                             \
    if(hipSuccess != gpuErr){                                                             \
        printf("CUDA Error - %s:%d: '%s'\n", __FILE__, __LINE__, hipGetErrorString(gpuErr));\
        exit(0);                                                                            \
    }                                                                                     \
}while(0)

#define N 512

int main(int argc, char *argv[])
{

    MPI_Init(&argc, &argv);
  
    int size;
    MPI_Comm_size(MPI_COMM_WORLD, &size);
  
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  
    char name[MPI_MAX_PROCESSOR_NAME];
    int resultlength;
    MPI_Get_processor_name(name, &resultlength);
    
    if(rank == 0) {
      printf("number of ranks: %d\n", size);
    }
    // Start Total Runtime Timer
    double start_time, end_time, elapsed_time;
    start_time = MPI_Wtime();

    // Set device to GPU 0
    gpuErrorCheck( hipSetDevice(0) );

    /* Allocate memory for A, B, C on CPU ----------------------------------------------*/
    double *A = (double*)malloc(N*N*sizeof(double));
    double *B = (double*)malloc(N*N*sizeof(double));
    double *C = (double*)malloc(N*N*sizeof(double));

    /* Set Values for A, B, C on CPU ---------------------------------------------------*/

    // Max size of random double
    double max_value = 10.0;

    // Set A, B, C
    for(int i=0; i<N; i++){
        for(int j=0; j<N; j++){
            A[i*N + j] = (double)rand()/(double)(RAND_MAX/max_value);
            B[i*N + j] = (double)rand()/(double)(RAND_MAX/max_value);
            C[i*N + j] = 0.0;
        }
    }

    /* Allocate memory for d_A, d_B, d_C on GPU ----------------------------------------*/
    double *d_A, *d_B, *d_C;
    gpuErrorCheck( hipMalloc(&d_A, N*N*sizeof(double)) );
    gpuErrorCheck( hipMalloc(&d_B, N*N*sizeof(double)) );
    gpuErrorCheck( hipMalloc(&d_C, N*N*sizeof(double)) );

    /* Copy host arrays (A,B,C) to device arrays (d_A,d_B,d_C) -------------------------*/
    gpuErrorCheck( hipMemcpy(d_A, A, N*N*sizeof(double), hipMemcpyHostToDevice) );
    gpuErrorCheck( hipMemcpy(d_B, B, N*N*sizeof(double), hipMemcpyHostToDevice) );
    gpuErrorCheck( hipMemcpy(d_C, C, N*N*sizeof(double), hipMemcpyHostToDevice) );	

    /* Perform Matrix Multiply on CPU --------------------------------------------------*/

    const double alpha = 1.0;
    const double beta = 0.0;

    cblas_dgemm(CblasColMajor, CblasNoTrans, CblasNoTrans, N, N, N, alpha, A, N, B, N, beta, C, N);

    /* Perform Matrix Multiply on GPU --------------------------------------------------*/

    hipblasHandle_t handle;
    hipblasCreate(&handle);

    hipblasStatus_t status = hipblasDgemm(handle, HIPBLAS_OP_N, HIPBLAS_OP_N, N, N, N, &alpha, d_A, N, d_B, N, &beta, d_C, N);
    if (status != HIPBLAS_STATUS_SUCCESS){
        printf("hipblasDgemm failed with code %d\n", status);
        return EXIT_FAILURE;
    }

	/* Copy values of d_C back from GPU and compare with values calculated on CPU ------*/

    // Copy values of d_C (computed on GPU) into host array C_fromGPU	
    double *C_fromGPU = (double*)malloc(N*N*sizeof(double));	
    gpuErrorCheck( hipMemcpy(C_fromGPU, d_C, N*N*sizeof(double), hipMemcpyDeviceToHost) );

    // Check if CPU and GPU give same results
    double tolerance = 1.0e-13;
    for(int i=0; i<N; i++){
        for(int j=0; j<N; j++){
            if(fabs((C[i*N + j] - C_fromGPU[i*N + j])/C[i*N + j]) > tolerance){
                printf("Element C[%d][%d] (%f) and C_fromGPU[%d][%d] (%f) do not match!\n", i, j, C[i*N + j], i, j, C_fromGPU[i*N + j]);
                return EXIT_FAILURE;
            }
        }
    }

    /* Clean up and output --------------------------------------------------------------*/

    hipblasDestroy(handle);

    // Free GPU memory
    gpuErrorCheck( hipFree(d_A) );
    gpuErrorCheck( hipFree(d_B) );
    gpuErrorCheck( hipFree(d_C) );

    // Free CPU memory
    free(A);
    free(B);
    free(C);
    free(C_fromGPU);

    end_time = MPI_Wtime();
    elapsed_time = end_time - start_time;
    double total_time_max;
    MPI_Reduce(&elapsed_time, &total_time_max, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

    if(rank == 0) {
      printf("Max MPI time (s)    = %.6f\n", total_time_max / 1000.0);
      printf("__SUCCESS__\n");
    }

    return 0;
}
