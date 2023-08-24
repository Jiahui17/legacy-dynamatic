
//------------------------------------------------------------------------
// If loop
//------------------------------------------------------------------------


#include <stdlib.h>
#include "if_loop_add.h"

float if_loop_add (in_float_t a[1000], in_float_t b[1000]) {
	int i;
 	float dist;
	float sum = 0.0;

	for (i=0; i<1000; i++) {
		dist = a[i] - b[i];

		if (dist >= 0){

		sum = (sum + dist);

	  	}

	}
return sum;
}

#define AMOUNT_OF_TEST 1

int main(void){
	in_float_t a[AMOUNT_OF_TEST][1000];
	in_float_t b[AMOUNT_OF_TEST][1000];
    
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int j = 0; j < 1000; ++j){
    		a[i][j] = (float) j;
			b[i][j] = (float) j + 10;

			if (j%100 == 0)
			   	b[i][j] = 0;
		}
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0;
	if_loop_add(a[i], b[i]);
	//}
}




