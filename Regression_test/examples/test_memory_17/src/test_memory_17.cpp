#include <stdlib.h>
#include "test_memory_17.h"

#define AMOUNT_OF_TEST 1

void test_memory_17(inout_int_t a[100], in_int_t b[100]) {


	for (int i = 0; i < 100; i++) {
		int x = a[i];
		if (b[i] > 5){
			x = 0;
			b[i] = 0;
		}
		else 
			x = 1;
		a[i] = x;

	}

}

int main(void){
	inout_int_t a[AMOUNT_OF_TEST][100];
	in_int_t n[AMOUNT_OF_TEST];
	in_int_t b[AMOUNT_OF_TEST][100];

	srand(13);
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		n[i] = 3;
		for(int j = 0; j < 100; ++j){
			a[i][j] = (rand() % 100) - 50;
			b[i][j] = (rand() % 100) - 50;
		}
	}
    
	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0;
	test_memory_17(a[i], b[i]);
	//}
}

