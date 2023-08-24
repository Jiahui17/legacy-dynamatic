#include "sumi3.h"



#include <stdlib.h>
#include "sumi3.h"

#define AMOUNT_OF_TEST 1

int sumi3()
{
	int sum = 0;
	for (int i = 0; i < 100; ++i) sum += i*i*i;
	return sum;
}

int main(void){
    
	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		sumi3();
	//}
}


