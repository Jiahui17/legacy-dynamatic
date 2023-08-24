#include <stdlib.h>
#include "diamond.h"

#define AMOUNT_OF_TEST 1


int diamond(in_int_t a[1000], in_int_t b[1000], out_int_t c[1000]) {
	int res = 0;
	int i = 0;
	for (int i = 0; i < 1000; i ++){
		int tmp = a[i];
		int tmp2 = b[i];
		if(tmp2 < 100){
			res *= tmp;
			res += 1;
			res += 1;
		}
		else{
			res += 1;
		}
		c[i] = res;
	}
	return c[0];
}

int main(void){
	in_int_t a[AMOUNT_OF_TEST][1000];
	in_int_t b[AMOUNT_OF_TEST][1000];
	out_int_t c[AMOUNT_OF_TEST][1000];

	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int j = 0; j < 1000; ++j){
			a[i][j] = rand() % 6;
			b[i][j] = 100;
			c[i][j] = 0;
		}
		a[i][900] = 30;
	}

	int i = 0;
	diamond(a[i], b[i], c[i]);
}
