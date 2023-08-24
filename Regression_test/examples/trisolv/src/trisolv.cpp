/**
 * trisolv.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#define N 1000

#include <stdlib.h>
#include "trisolv.h"

void trisolv(out_int_t x[N], in_int_t A[N][N], in_int_t c[N] )
{
  int i, j;

  for (i = 0; i < N; i++)
    {
      x[i] = c[i];
      for (j = 0; j <= i - 1; j++)
        x[i] = x[i] - A[i][j] * x[j];
      x[i] = x[i] / A[i][i];
    }

}


#define AMOUNT_OF_TEST 1

int main(void){
	out_int_t xArray[AMOUNT_OF_TEST][N];
	in_int_t A[AMOUNT_OF_TEST][N][N];
	in_int_t c[AMOUNT_OF_TEST][N];

	srand(13);
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int y = 0; y < N; ++y){
      c[i][y] = rand() % 100;
		  for(int x = 0; x < N; ++x){
			    A[i][y][x] = rand() % 100 + 1;
		    }
	    }
    }
    
	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    int i = 0;
	trisolv(xArray[i], A[i], c[i]);
	//}
}





