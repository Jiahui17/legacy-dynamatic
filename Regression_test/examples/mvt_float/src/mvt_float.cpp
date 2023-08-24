#include "mvt_float.h"
/**
 * This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */


#include <stdlib.h>


#define N 4000


void mvt_float(in_float_t A[30][30], inout_float_t x1[30], inout_float_t x2[30], in_float_t y1[30], in_float_t y2[30])
{
   int i, j, k;

   for (i = 0; i < 30; i++) {
   	float tmp = x1[i];
    for (j = 0; j < 30; j++)
      tmp = tmp + A[i][j] * y1[j];
    x1[i] = tmp;
	}

  for (i = 0; i < 30; i++) {
  	float tmp = x2[i];
    for (j = 0; j < 30; j++)
      tmp = tmp + A[j][i] * y2[j];
  	x2[i] = tmp;
	}
}



#define AMOUNT_OF_TEST 1

int main(void){

	  in_float_t A[AMOUNT_OF_TEST][30][30];
	  inout_float_t x1[AMOUNT_OF_TEST][30];
	  inout_float_t x2[AMOUNT_OF_TEST][30];
	  in_float_t y1[AMOUNT_OF_TEST][30];
	  in_float_t y2[AMOUNT_OF_TEST][30];

    
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    	for(int y = 0; y < 30; ++y){
    		x1[i][y] = rand()%2;
    		x2[i][y] = rand()%2;
    		y1[i][y] = rand()%2;
    		y2[i][y] = rand()%2;
    	    for(int x = 0; x < 30; ++x){
			      A[i][y][x] = rand()%2;
          	}
		 }
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0; 
	mvt_float(A[i], x1[i], x2[i], y1[i], y2[i]);
	//}
}




