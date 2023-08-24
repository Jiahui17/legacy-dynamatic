
//------------------------------------------------------------------------
// If loop
//------------------------------------------------------------------------


#include <stdlib.h>
#include "matching.h"

float matching(in_int_t edges[1000], inout_int_t vertices[1000], in_int_t num_edges) {

    int i   = 0;
    float out = 0;

    while (i < num_edges) {

        int j = i * 2;

        int u = edges[j];
        int v = edges[j + 1];

        int t1 = vertices[u];
        int t2 = vertices[v];

        if ((t1 < 0) && (t2 < 0)) {
            vertices[u] = v;
            vertices[v] = u;

            out = out + 1;
        }

        i = i + 1;
    }

    return out;
}


#define AMOUNT_OF_TEST 1

int main(void){
	in_int_t edges[AMOUNT_OF_TEST][1000];
	inout_int_t vertices[AMOUNT_OF_TEST][1000];
    
	for(int i = 0; i < AMOUNT_OF_TEST; ++i){
		for(int j = 0; j < 1000; ++j){
    		edges[i][j] = (j+10) % 1000;;
    		vertices[i][j] = 700-j % 1000;
		}
	}

	//for(int i = 0; i < AMOUNT_OF_TEST; ++i){
	int i = 0;
	matching(edges[0], vertices[0], 400);
	//}
}




