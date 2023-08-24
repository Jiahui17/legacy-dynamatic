/**
 * 2mm.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */

#include "kernel_2mm_float.h"
#include <stdio.h>
#include <stdlib.h>

void kernel_2mm_float(in_float_t alpha, in_float_t beta, inout_float_t tmp[N][N], in_float_t A[N][N], in_float_t B[N][N], in_float_t C[N][N], inout_float_t D[N][N])
{
  int i, j, k;

  for (i = 0; i < NI; i++)
    for (j = 0; j < NJ; j++)
      {
    	float x = tmp[i][j];
    	for (k = 0; k < NK; ++k)
    	  x += alpha * A[i][k] * B[k][j];
    	tmp[i][j] = x;
      }
  for (i = 0; i < NI; i++)
    for (j = 0; j < NL; j++)
      {
      	float x = D[i][j]*beta;
	
      	for (k = 0; k < NJ; ++k)
      	  x += tmp[i][k] * C[k][j];
      	D[i][j] = x;
      }
}



#define AMOUNT_OF_TEST 1

int main(void){
    in_float_t alpha[AMOUNT_OF_TEST];
    in_float_t beta[AMOUNT_OF_TEST];
    in_float_t tmp[AMOUNT_OF_TEST][N][N];
    in_float_t A[AMOUNT_OF_TEST][N][N];
    in_float_t B[AMOUNT_OF_TEST][N][N];
    in_float_t C[AMOUNT_OF_TEST][N][N];
    inout_float_t D[AMOUNT_OF_TEST][N][N];
    

    for(int i = 0; i < AMOUNT_OF_TEST; ++i){
        alpha[i] = 1;
        beta[i] = 1;
        for(int y = 0; y < N; ++y){
            for(int x = 0; x < N; ++x){
                A[i][y][x] = rand()%2;
                B[i][y][x] = rand()%2;
                C[i][y][x] = rand()%2;
                D[i][y][x] = rand()%2;
            }
        }
    }

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		int i = 0;
        kernel_2mm_float(alpha[0], beta[0], tmp[0], A[0], B[0], C[0], D[0]);
	//}
	
}


