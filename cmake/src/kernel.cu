#include <cuda.h>
#include "kernel.h"
#include <stdio.h>

__global__ void simpleKernel() {
    printf("Hello from block %d, thread %d\n", blockIdx.x, threadIdx.x);
}

extern "C" {
  void runKernel() {
    simpleKernel<<<1, 10>>>();
    cudaDeviceSynchronize();
  }
}
