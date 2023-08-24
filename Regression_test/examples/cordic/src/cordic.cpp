#include "cordic.h"


#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define AMOUNT_OF_TEST 1

float cordic (in_float_t theta, out_float_t a[2], in_float_t cordic_phase[1000], in_float_t current_cos, in_float_t current_sin){

	float factor = 1.0;

	for (int i = 0; i < 1000; i++) {
		float sigma = (theta < 0) ? -1.0 : 1.0;
		float tmp_cos = current_cos;

		current_cos = current_cos - current_sin*sigma*factor;
		current_sin = tmp_cos*sigma*factor + current_sin;

		theta = theta - sigma*cordic_phase[i];
		factor = factor/2 ;
	}
	a[0] = current_cos;
	a[1] = current_sin;
	return theta;
}

int main(void){
	in_float_t thetas[AMOUNT_OF_TEST];
    out_float_t results[AMOUNT_OF_TEST][2];
    in_float_t cordic_phases[1000]; //useless, is 1 after 12 iterations
    in_float_t initial_cos = 1;
    in_float_t initial_sin = 0;
    //generate cordic_phases
    for(int i = 0; i < 1000; ++i){
        double div = 1;//sqrtf(1 + powf(2, -2*i));
        cordic_phases[i] = 1/div;
    }
    
	//srand(13);
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
        thetas[i] = 1;//fmodf((float) rand(), 2*M_PI);
        results[i][0] = 0;
        results[i][1] = 0;
	}
	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0;
	cordic(thetas[i], results[i], cordic_phases, initial_cos, initial_sin);
	//}
}


