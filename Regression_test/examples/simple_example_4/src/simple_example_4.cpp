#include "simple_example_4.h"

int simple_example_4(in_int_t c){
	int sum = c;
	for (int i = 1; i < 100; i++){
    	sum = sum*i + 1000;
    }
    return sum;
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
        int x = simple_example_4(a[0][0]);
	}
	
}