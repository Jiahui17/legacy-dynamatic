/**
 * atax.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */
#include "atax.h"

#define NX 20
#define NY 20
#define N 20

#include <stdlib.h>

#define AMOUNT_OF_TEST 1

void atax(in_int_t A[N][N], in_int_t x[N], inout_int_t y[N], inout_int_t tmp[N])
{
  int i, j;

  for (i = 0; i < NY; i++)
    y[i] = 0;
  for (i = 0; i < NX; i++)
    {
      tmp[i] = 0;
      for (j = 0; j < NY; j++)
	tmp[i] = tmp[i] + A[i][j] * x[j];
      for (j = 0; j < NY; j++)
	y[j] = y[j] + A[i][j] * tmp[i];
    }

}

int main(void){
    in_int_t A[AMOUNT_OF_TEST][N][N];
    in_int_t x[AMOUNT_OF_TEST][N];
    inout_int_t y[AMOUNT_OF_TEST][N];
    inout_int_t tmp[AMOUNT_OF_TEST][N];
  
    
    srand(13);

    for(int i = 0; i < AMOUNT_OF_TEST; ++i){
        for(int j = 0; j < N; ++j){
            x[i][j] = rand()%100;
            y[i][j] = rand()%100;
            tmp[i][j] = rand()%100;
            for(int x = 0; x < N; ++x){
                A[i][j][x] = rand()%100;
            }
        }
    }

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		int i = 0;
        atax(A[0], x[0], y[0], tmp[0]);
	//}
	
}




