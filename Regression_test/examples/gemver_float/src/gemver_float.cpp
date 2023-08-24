#include "gemver_float.h"

/**
 * gemver.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

#define N 10


#include <stdlib.h>

void gemver_float(in_float_t alpha, in_float_t beta, inout_float_t A[N][N],
 in_float_t u1[N], in_float_t v1[N], in_float_t u2[N], in_float_t v2[N], inout_float_t w[N], inout_float_t x[N], in_float_t y[N], in_float_t z[N])
{
  int i, j;

	for (i = 0; i < N; i++)
	    for (j = 0; j < N; j++)
	      A[i][j] = A[i][j] + u1[i] * v1[j] + u2[i] * v2[j];
 
	  for (i = 0; i < N; i++) {
	    float tmp = x[i];
	    for (j = 0; j < N; j++)
	      tmp = tmp + beta * A[j][i] * y[j];
	    x[i] = tmp;
	  }

  for (i = 0; i < N; i++)

    x[i] = x[i] + z[i];

  for (i = 0; i < N; i++) {
   float tmp = w[i];
    for (j = 0; j < N; j++)
      tmp = tmp +  alpha * A[i][j] * x[j];
    w[i] = tmp;
  }

}

#define AMOUNT_OF_TEST 1

int main(void){
	  in_float_t alpha[AMOUNT_OF_TEST];
	  in_float_t beta[AMOUNT_OF_TEST];
	  inout_float_t A[AMOUNT_OF_TEST][N][N];
	  in_float_t u1[AMOUNT_OF_TEST][N];
	  in_float_t v1[AMOUNT_OF_TEST][N];
	  in_float_t u2[AMOUNT_OF_TEST][N];
	  in_float_t v2[AMOUNT_OF_TEST][N];
	  inout_float_t w[AMOUNT_OF_TEST][N];
	  inout_float_t x[AMOUNT_OF_TEST][N];
	  in_float_t y[AMOUNT_OF_TEST][N];
	  in_float_t z[AMOUNT_OF_TEST][N];

  
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    alpha[i] = rand()% 20;
    beta[i] = rand()% 20;
    	for(int yy = 0; yy < N; ++yy){
        u1[i][yy] = rand()% 20;
        v1[i][yy] = rand()% 20;
        u2[i][yy] = rand()% 20;
        v2[i][yy] = rand()% 20;
        w[i][yy] = rand()% 20;
        x[i][yy] = rand()% 20;
        y[i][yy] = rand()% 20;
        z[i][yy] = rand()% 20;
    	    for(int x = 0; x < N; ++x){
			      A[i][yy][x] = rand()%10;
          }
		  }
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		int i = 0;
		gemver_float(alpha[i], beta[i], A[i], u1[i], v1[i], u2[i], v2[i], w[i], x[i], y[i], z[i]);
	//}
}





