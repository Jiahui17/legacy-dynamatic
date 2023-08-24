/**
 * covariance.c: This file is part of the PolyBench/C 3.2 test suite.
 *
 *
 * Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>
 * Web address: http://polybench.sourceforge.net
 */

#include "correlation_float.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define AMOUNT_OF_TEST 1

void correlation_float(inout_float_t data[30][30], inout_float_t mean[30], out_float_t symmat[30][30], inout_float_t stdev[30]) {
    int i, j, j1, j2;
    float float_n = 10.0;
    float sqrt_float_n = 3.16;
    float eps     = 0.1f;

    /* Determine mean of column vectors of input data matrix */
    for (j = 0; j < 10; j++) {
        float x = 0.0;
        for (i = 0; i < 10; i++)
            x += data[i][j];
        mean[j] = x / float_n;
    }

    /* Determine standard deviations of column vectors of data matrix. */
    for (j = 0; j < 10; j++) {
        float x = 0.0;
        for (i = 0; i < 10; i++)
            x += (data[i][j] - mean[j]) * (data[i][j] - mean[j]);
        x /= float_n;
        x = x*x;//sqrt(x);

        /* The following in an inelegant but usual way to handle
     near-zero std. dev. values, which below would cause a zero-
     divide. */
        stdev[j] = x ;//<= eps ? 1.0 : x;
    }

    /* Center and reduce the column vectors. */
    for (i = 0; i < 10; i++)
        for (j = 0; j < 10; j++) {
            float x = data[i][j];
            x -= mean[j];
            //float n = sqrt(float_n);
            x /= sqrt_float_n  * stdev[j];
            data[i][j] = x;
        }

    /* Calculate the m * m correlation matrix. */
    for (j1 = 0; j1 < 9; j1++) {
        symmat[j1][j1] = 1.0;
        for (j2 = j1 + 1; j2 < 10; j2++) {
            float x = 0.0;
            for (i = 0; i < 10; i++)
                x += (data[i][j1] * data[i][j2]);
            symmat[j1][j2] = x;
            symmat[j2][j1] = x;
        }
    }
    symmat[9][9] = 1.0;
}

int main(void){
	  inout_float_t data[AMOUNT_OF_TEST][30][30];
	  out_float_t symmat[AMOUNT_OF_TEST][30][30];
	  inout_float_t mean[AMOUNT_OF_TEST][30];
	  inout_float_t stdev[AMOUNT_OF_TEST][30];
    
	srand(13);
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    for(int y = 0; y < 30; ++y){
      for(int x = 0; x < 30; ++x){
        data[i][y][x] = rand()%100;
      }
    }
	}

	//or(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0;
	correlation_float(data[i], mean[i], symmat[i], stdev[i]);
	//}
}






