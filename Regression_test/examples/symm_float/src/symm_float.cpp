#include "symm_float.h"
/**
 * This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */


#include <stdlib.h>


#define N 4000


void symm_float(in_float_t A[30][30], in_float_t B[30][30], inout_float_t C[30][30], in_float_t alpha, in_float_t beta)
{
   int i, j, k;

   for (i = 0; i < 10; i++)
    for (j = 0; j < 30; j++)
      {
		float acc = 0;
		for (k = 0; k < j - 1; k++)
		  {
		    C[k][j] += alpha * A[k][i] * B[i][j];
		    acc += B[k][j] * A[k][i];
		  }
		C[i][j] = beta * C[i][j] + alpha * A[i][i] * B[i][j] + alpha * acc;
      }
}



#define AMOUNT_OF_TEST 1

int main(void){

	  in_float_t A[AMOUNT_OF_TEST][30][30];
    in_float_t B[AMOUNT_OF_TEST][30][30];
	  inout_float_t C[AMOUNT_OF_TEST][30][30];
	  in_float_t alpha[AMOUNT_OF_TEST][30];
	  in_float_t beta[AMOUNT_OF_TEST][30];

    
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    	for(int y = 0; y < 30; ++y){
    		alpha[i][y] = rand()%2;
    		beta[i][y] = rand()%2;

    	    for(int x = 0; x < 30; ++x){
			      A[i][y][x] = rand()%2;
            B[i][y][x] = rand()%2;
            C[i][y][x] = rand()%2;
          	}
		 }
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0; 
	symm_float(A[i], B[i], C[i], alpha[i][0], beta[i][0]);

	//}
}




