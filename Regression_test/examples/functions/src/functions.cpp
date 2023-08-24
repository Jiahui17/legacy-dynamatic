

#include <stdlib.h>
#include "functions.h"

#define AMOUNT_OF_TEST 1

//void my_func(out_int_t sum[10][10], in_int_t a[10][10], in_int_t ind ) {

//	for (int j=0;j<10;j++) {
//			sum[ind][j]=a[ind][j]+5;
//		}

//}

void functions (out_int_t sum[10][10], in_int_t a[10][10] ) {
	int i,j;

	for (i=0;i<10;i+=2) {
		//my_func(sum, a, i);
		//my_func(sum, a, i+1);
		for (j=0;j<10;j++) {
			sum[i][j]=a[i][j]+5;
		}

		for (j=0;j<10;j++) {
			sum[i+1][j]=a[i+1][j]+5;
		}

	}


}

int main(void){
	  out_int_t sum[AMOUNT_OF_TEST][10][10];
	  in_int_t a[AMOUNT_OF_TEST][10][10];

    
	srand(13);
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    	for(int j = 0; j < 10; ++j){
    		for(int k = 0; k < 10; ++k){
				sum[0][j][k] = 0;
				a[0][j][k] = rand() % 100;
			}
		}
	}

	for(int i = 0; i < 1; ++i){
		functions(sum[0], a[0] );
	}
}

//SEPARATOR_FOR_MAIN


