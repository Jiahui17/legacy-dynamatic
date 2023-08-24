#include "gesummv_float.h"
/**
 * This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */


#include <stdlib.h>


void gesummv_float(in_float_t alpha, in_float_t beta, in_float_t A[30][30], in_float_t B[30][30], out_float_t tmp[30], out_float_t y[30] , in_float_t x[30])
{
  int i, j, k;

 for (i = 0; i < 30; i++)
    {
      float t_tmp = 0;
      float t_y = 0;

      for (j = 0; j < 30; j++)
		{
		  float t_x = x[j];
		  t_tmp = A[i][j] * t_x + t_tmp;
		  t_y  = B[i][j] * t_x + t_y;
		}

	  tmp[i] = t_tmp;
      y[i] = alpha * t_tmp + beta * t_y;
    }
}


#define AMOUNT_OF_TEST 1

int main(void){
	  in_float_t alpha[AMOUNT_OF_TEST];
	  in_float_t beta[AMOUNT_OF_TEST];
	  in_float_t A[AMOUNT_OF_TEST][30][30];
	  in_float_t B[AMOUNT_OF_TEST][30][30];
	  out_float_t tmp[AMOUNT_OF_TEST][30];
	  out_float_t y[AMOUNT_OF_TEST][30];
	  in_float_t x[AMOUNT_OF_TEST][30];
    
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    alpha[i] = 1;
    beta[i] = 1;
    	for(int  j = 0; j  < 30; ++j){
    		tmp[i][j] = 1;
			x[i][j] = rand()%2;
			y[i][j] = rand()%2;
    	    for(int k = 0; k < 30; ++k){
			      A[i][j][k] = rand()%3;
			      B[i][j][k] = rand()%2;


          }
		  }
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0; 
	gesummv_float(alpha[i], beta[i], A[i], B[i], tmp[i], y[i], x[i]);
	//}
}




