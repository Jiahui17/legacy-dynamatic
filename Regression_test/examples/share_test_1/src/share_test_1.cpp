#include "share_test_1.h"


#include <stdlib.h>


#define AMOUNT_OF_TEST 1

int share_test_1(in_int_t a[1000], in_int_t b[1000] ) {
    int i;
    int tmp=0;

    For_Loop1: for (i=0;i<1000;i++) {
        tmp += a[i] *b[999-i] * 5;

    }

    For_Loop2: for (i=0;i<1000;i++) {
        tmp += a[999-i] * b[i];

    }

        //out [0] = tmp;
    return tmp;
}

int main(void){
      in_int_t d_i[AMOUNT_OF_TEST][1000];
      in_int_t idx[AMOUNT_OF_TEST][1000];
      inout_int_t out[AMOUNT_OF_TEST][1000];    
    
    srand(13);
    for(int i = 0; i < AMOUNT_OF_TEST; ++i){
        for(int j = 0; j < 1000; ++j){
            d_i[0][j] = rand() % 100;
            idx[0][j] = rand() % 100;
        }
    }

    for(int i = 0; i < 1; ++i){
        share_test_1(d_i[0], idx[0] );
    }
}

//SEPARATOR_FOR_MAIN


