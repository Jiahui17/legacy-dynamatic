//------------------------------------------------------------------------
// While loop
//------------------------------------------------------------------------


#include <stdlib.h>
#include "while_loop_3.h"

#define AMOUNT_OF_TEST 1

void while_loop_3 (out_int_t a[1]) {
	int i = 0;
	int bound = 1000;
	int sum = 0;

	while (i*i < 1000) {
		i++;
	
	}
a[0] = i;
}

int main(void){
	out_int_t a[AMOUNT_OF_TEST][1];
    
	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		int i = 0;
		while_loop_3(a[i]);
	//}
}






