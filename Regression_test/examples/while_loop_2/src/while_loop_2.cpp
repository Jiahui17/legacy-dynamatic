//------------------------------------------------------------------------
// While loop
//------------------------------------------------------------------------
//SEPARATOR_FOR_MAIN

#include <stdlib.h>
#include "while_loop_2.h"

void while_loop_2 (inout_int_t a[1000]) {
	int i = 0;
	int bound = 1000;
	int sum = 0;

	while (a[i] != 0) {
		i++;
	
	}
a[0] =i;
}


#define AMOUNT_OF_TEST 1

int main(void){
	inout_int_t a[AMOUNT_OF_TEST][1000];

	srand(13);
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int j = 0; j < 1000; ++j){
			a[i][j] = rand() % 100;
	    }
		a[i][999] = 0;
    }
    
	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    int i = 0;
	while_loop_2(a[i]);
	//}
}





