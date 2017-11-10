/*
 * TestExt.xc
 *
 *  Created on: 8 Oct 2017
 *      Author: davie
 */

#include <stdio.h>

extern void hello(int x);

void goodbye() {
    printf("goodbye!");
    hello(600);
}



