//------------------------------------------------------------------------
// While loop
//------------------------------------------------------------------------

#include <stdlib.h>
#include "while_loop_1.h"

void while_loop_1 (inout_int_t a[1000], in_int_t b[1000]) {
	int i = 0;
	int bound = 1000;
	int sum = 0;

	while (sum < bound) {

		sum = a[i] + b[i];
		a[i] = sum;
		i++;
	
	}
}

#define AMOUNT_OF_TEST 1

int main(void){
	inout_int_t a[AMOUNT_OF_TEST][1000];
	inout_int_t b[AMOUNT_OF_TEST][1000];

	srand(13);
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){

		for(int j = 0; j < 1000; ++j){
			a[i][j] = rand() % 10;
			b[i][j] = rand() % 10;
	    }
       a[i][900] = 600;
       b[i][900] = 600;
    }
    
	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    int i = 0;
	while_loop_1(a[i], b[i]);
	//}
}







