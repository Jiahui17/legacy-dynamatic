#include "gemm.h"
/**
 * gemver.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */


#include <stdlib.h>


#define N 4000


void gemm(in_int_t alpha, in_int_t beta, in_int_t A[30][30], in_int_t B[30][30], inout_int_t C[30][30] )
{
  int i, j, k;

 for (i = 0; i < 30; i++)
    for (j = 0; j < 30; j++)
      {
      	int tmp = C[i][j] *beta;
		for (k = 0; k < 30; ++k)
		    tmp += alpha * A[i][k] * B[k][j];

		C[i][j] = tmp;
      }
}


#define AMOUNT_OF_TEST 1

int main(void){
	  in_int_t alpha[AMOUNT_OF_TEST];
	  in_int_t beta[AMOUNT_OF_TEST];
	  in_int_t A[AMOUNT_OF_TEST][30][30];
	  in_int_t B[AMOUNT_OF_TEST][30][30];
	  out_int_t C[AMOUNT_OF_TEST][30][30];
    
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    alpha[i] = 1;//rand()% 1;
    beta[i] = 1;//rand()% 1;
    	for(int y = 0; y < 30; ++y){
    	    for(int x = 0; x < 30; ++x){
			      A[i][y][x] = 1;//rand()%1;
			      B[i][y][x] = 1;//rand()%2;
			      C[i][y][x] = 0;

          }
		  }
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0; 
	gemm(alpha[i], beta[i], A[i], B[i], C[i]);
	//}
}




