//------------------------------------------------------------------------
// While loop
//------------------------------------------------------------------------


#include <stdlib.h>
#include "while_loop_4.h"

#define AMOUNT_OF_TEST 1

void while_loop_4 (in_int_t a[1000], in_int_t b[1000], out_int_t c[1000]) {
	int i = 0;
	int bound = 1000;
	int sum = 0;

	while (sum < bound) {

		sum = a[i] + b[i];
		c[i] = sum;
		i++;
	
	}
}

int main(void){
	in_int_t a[AMOUNT_OF_TEST][1000];
	in_int_t b[AMOUNT_OF_TEST][1000];
	out_int_t c[AMOUNT_OF_TEST][1000];


	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int j = 0; j < 1000; ++j){
			a[i][j] = rand() % 100;
			b[i][j] = rand() % 100;
                        c[i][j] = 0;
	    }
	a[i][900] = 600;
	b[i][900] = 600;
    }
    
	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
    int i = 0;
	while_loop_4(a[i], b[i], c[i]);
	//}
}

//SEPARATOR_FOR_MAIN





