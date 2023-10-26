#include <stdio.h>
#include <cuda_runtime.h>

#include "/home/mashaobo/cuBiT/tools/common.cuh"

__global__ void test(uint *A, uint *B){
    printf("%x\n",*A);
    printf("%x\n",*B);
    printf("%x\n", __popc(*A));
    printf("%x\n", __popc(*B));
    return;
}

int main(){
    uint A = 0xabcdabcd;
    uint B = 0x0f0f0f0f;
    
    uint *dA, *dB;

    printf("cpu%x\n",A);
    printf("cpu%x\n",B);

    cudaMalloc(&dA, sizeof(uint));
    cudaMalloc(&dB, sizeof(uint));
    
    cudaMemcpy(dA, &A, sizeof(uint), cudaMemcpyHostToDevice); 
    cudaMemcpy(dB, &B, sizeof(uint), cudaMemcpyHostToDevice); 

    test<<<1,1>>>(dA, dB);
    cudaDeviceSynchronize();

    cudaFree(dA);
    cudaFree(dB);
    return 0;
}
