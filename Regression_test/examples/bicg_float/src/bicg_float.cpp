/**
 * bicg.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */
#include "bicg_float.h"

#define NX 30
#define NY 30
#define N 30

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

float  bicg_float(in_float_t A[N][N], inout_float_t s[N], inout_float_t q[N], in_float_t p[N], in_float_t r[N])
{
  int i, j;

  float tmp_q = 0;

  for (i = 0; i < NX; i++)
    {
      tmp_q = q[i];
      for (j = 0; j < NY; j++)
        {
          float tmp =  A[i][j];
          s[j] = s[j] + r[i] * tmp;
          tmp_q = tmp_q + tmp * p[j];
        }
       q[i] = tmp_q;

    }
return tmp_q;
}


#define AMOUNT_OF_TEST 1

int main(void){
    in_float_t A[AMOUNT_OF_TEST][N][N];
    inout_float_t s[AMOUNT_OF_TEST][N];
    inout_float_t q[AMOUNT_OF_TEST][N];
    in_float_t p[AMOUNT_OF_TEST][N];
    in_float_t r[AMOUNT_OF_TEST][N];
    
    for(int i = 0; i < AMOUNT_OF_TEST; ++i){
        for(int y = 0; y < N; ++y){
            s[i][y] = rand()%100;
            q[i][y] = rand()%100;
            p[i][y] = rand()%100;
            r[i][y] = rand()%100;
            for(int x = 0; x < N; ++x){
                A[i][y][x] = rand()%100;
            }
        }
    }

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){ 
    int i = 0;
    bicg_float(A[i], s[i], q[i], p[i], r[i]);
	//}
	
}





