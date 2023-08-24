
/**

* jacobi-1d-imper.c: This file is part of the PolyBench/C 3.2 test suite.

*

*

* Contact: Louis-Noel Pouchet <pouchet@cse.ohio-state.edu>

* Web address: http://polybench.sourceforge.net

*/



#define TSTEPS 3
#define N 100


#include <stdlib.h>
#include "jacobi_1d_imper.h"



void jacobi_1d_imper(inout_int_t A[N], inout_int_t B[N])
{
	int t, i, j;



	for (t = 0; t < TSTEPS; t++)

	{

		for (i = 1; i < N - 1; i++)
		    B[i] = 3 * (A[i-1] + A[i] + A[i + 1]);

		for (j = 1; j < N - 1; j++)
		    A[j] = B[j];

	}
}



#define AMOUNT_OF_TEST 1



int main(void){

    inout_int_t A[AMOUNT_OF_TEST][N];
    inout_int_t B[AMOUNT_OF_TEST][N];


    for(int i = 0; i < AMOUNT_OF_TEST; ++i){

        for(int j = 0; j < N; ++j){
            A[i][j] = rand()%100;
            B[i][j] = rand()%100;
        }
	}



    //for(int i = 0; i < AMOUNT_OF_TEST; ++i){

        int i = 0;

        jacobi_1d_imper(A[i], B[i]);

    //}

}