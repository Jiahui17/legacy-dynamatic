#include "path_profiling.h"
#include <stdio.h>

void path_profiling(out_int_t a[100], out_int_t b[100]){
    for (int i = 0; i < 100; ++i){
       if(i % 2 == 0){
           a[i] = 2;
       }else{
           a[i] = 3;
       }
       if(i % 3 == 0){
           b[i] = 2;
       }else{
           b[i] = 3;
       }
    }
}

//---split-here---


#define AMOUNT_OF_TEST 1

int main(void){
    in_int_t a[100];
    in_int_t b[100];
    
    path_profiling(a, b);
}