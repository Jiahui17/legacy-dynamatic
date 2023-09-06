//------------------------------------------------------------------------
// While loop
//------------------------------------------------------------------------


#include <stdlib.h>
#include "while_loop_3.h"

#define AMOUNT_OF_TEST 1
#define BOUND 1000


void while_loop_3 (out_int_t a[ARRAY_SIZE], in_int_t bound) {
	int i = 0;
	int sum = 0;

	while (i*i < bound) {
		i++;

	}
	a[0] = i;
}

int main(void){
	out_int_t a[AMOUNT_OF_TEST][ARRAY_SIZE];
	in_int_t bound[AMOUNT_OF_TEST];

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	for (int i = 0; i< AMOUNT_OF_TEST; i++){
		bound[i] = 1;
		for ( int j = 0; j < ARRAY_SIZE; j++) {
			a[i][j] = 0;
		}
	}

	int i = 0;
	while_loop_3(a[i], bound[i]);
	//}
}






