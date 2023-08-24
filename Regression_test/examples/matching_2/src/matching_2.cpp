
//------------------------------------------------------------------------
// If loop
//------------------------------------------------------------------------


#include <stdlib.h>
#include "matching_2.h"

void matching_2(in_int_t edges[1000], inout_float_t vertices[1000], in_int_t num_edges) {

    int i   = 0;


    while (i < num_edges) {

        int j = i * 2;

        int u =  edges[j];
        int v =  edges[j + 1];

        float t1 = vertices[u];
        float t2 = vertices[v];

        if ((t1 < 0) && (t2 < 0)) {
            vertices[u] = v;
            vertices[v] = u;

        }

        i = i + 1;
    }

}


#define AMOUNT_OF_TEST 1

int main(void){
	in_int_t edges[AMOUNT_OF_TEST][1000];
	inout_float_t vertices[AMOUNT_OF_TEST][1000];
    
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int j = 0; j < 1000; ++j){
    		edges[i][j] = (j+10) % 1000;
    		vertices[i][j] = 700-j % 1000;
		}
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0;
	matching_2(edges[0], vertices[0], 400);
	//}
}




