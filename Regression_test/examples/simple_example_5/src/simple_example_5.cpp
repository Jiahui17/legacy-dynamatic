#include "simple_example_5.h"

void simple_example_5(inout_int_t a[100], in_int_t b[100]){
	int sum = 1;
	for (int i = 1; i < 20; i++){
    	sum = sum*i;
        int addr = b[i];
        a[addr]=sum;
    }
}


#define AMOUNT_OF_TEST 1

int main(void){
    in_int_t a[AMOUNT_OF_TEST][100];
    in_int_t b[AMOUNT_OF_TEST][100];
    in_int_t c[AMOUNT_OF_TEST];
    
    for(int i = 0; i < AMOUNT_OF_TEST; ++i){
        c[i] = 3;
        for(int j = 0; j < 100; ++j){
            a[i][j] = j;
            b[i][j] = 99 - j;
        }
    }

	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
        simple_example_5(a[0], b[0]);
	}
	
}