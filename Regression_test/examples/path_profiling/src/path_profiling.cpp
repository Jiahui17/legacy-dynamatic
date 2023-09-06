#include "path_profiling.h"

#define AMOUNT_OF_TEST 1
#include <stdlib.h>

void path_profiling(out_int_t a[LOOP_BOUND], out_int_t b[LOOP_BOUND], in_int_t var[LOOP_BOUND]){
	for (int i = 0; i < LOOP_BOUND; ++i){
		if(var[i] % 2 == 0){
			a[i] = 2;
		}else{
			a[i] = 3;
		}
		if(var[i] % 3 == 0){
			b[i] = 2;
		}else{
			b[i] = 3;
		}
	}
}

//---split-here---

int main(void){
	out_int_t a[AMOUNT_OF_TEST][LOOP_BOUND];
	out_int_t b[AMOUNT_OF_TEST][LOOP_BOUND];
	in_int_t var[AMOUNT_OF_TEST][LOOP_BOUND];

	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int j = 0; j < LOOP_BOUND; ++j){
			a[i][j] = 0;
			b[i][j] = 0;
			var[i][j] = rand() % 100;
		}
	}

	int iteration = 0;
	path_profiling(a[iteration], b[iteration], var[iteration]);
}
