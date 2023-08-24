#include <stdlib.h>
#include "if_loop_5.h"

int if_loop_5 (in_int_t a[1000], in_int_t b[1000]) {
	int i;
 	int dist;
	int sum = 1;

	for (i=0; i<1000; i++) {
		dist = a[i] - b[i];

		if (dist >= 0){

		sum = (dist + sum * dist)*dist;
		//(((((d+(float)0.64)*d+(float)0.7)*d+(float)0.21)*d+(float)0.33)*d);

	  	}

	}
return sum;
}

#define AMOUNT_OF_TEST 1

int main(void){
	in_int_t a[AMOUNT_OF_TEST][1000];
	in_int_t b[AMOUNT_OF_TEST][1000];
    
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int j = 0; j < 1000; ++j){
    		a[i][j] = rand()%10;
    		b[i][j] = a[i][j]+1;

    		if (j%100 == 0)
    			b[i][j] = 0;
		}
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0;
	if_loop_5(a[i], b[i]);
	//}
}