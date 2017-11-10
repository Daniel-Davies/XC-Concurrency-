/*
 * HelloExt2.xc
 *
 *  Created on: 8 Oct 2017
 *      Author: davie
 */


#include <stdio.h>
#include <platform.h>

extern void goodbye();

void hello(int x) {
    printf("Hello from core %d\n",x);
    //goodbye();
}

int main(void) {
    par {
        on tile[0] : hello(0);
        on tile[1] : hello(1);
        on tile[0] : goodbye();
    }
    return 0;
}
