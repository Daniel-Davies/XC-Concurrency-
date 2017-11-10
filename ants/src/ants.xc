/*
 * ants.xc
 *
 *  Created on: 2 Oct 2017
 *      Author: davie
 */

#include <stdio.h>
#include <platform.h>

struct Ant {
    int food;
    int positionX;
    int positionY;
    int ID;
};

typedef char Worlds[4][3];

void initialiseWorld(char new[4][3]) {
    (new)[0][0] = 10;
    (new)[0][1] = 2;
    (new)[0][2] = 6;
    (new)[1][0] = 0;
    (new)[1][1] = 10;
    (new)[1][2] = 8;
    (new)[2][0] = 1;
    (new)[2][1] = 0;
    (new)[2][2] = 7;
    (new)[3][0] = 7;
    (new)[3][1] = 3;
    (new)[3][2] = 6;
}

struct Ant mve(struct Ant ant, char world[4][3]) {
    int eastMove = world[(ant.positionX+1)%4][(ant.positionY)];
    int sothMove = world[(ant.positionX)][(ant.positionY+1)%3];
    if (eastMove > sothMove) {
        ant.positionX =(ant.positionX + 1) % 4;
        ant.food = ant.food + eastMove;
    }
    else {
        ant.positionY = (ant.positionY +1) % 3;
        ant.food = ant.food + sothMove;
    }
    return ant;
}


struct Ant initAnt(int posx, int posy, int id) {
    struct Ant temp;
    temp.food = 0;
    temp.positionX = posx;
    temp.positionY = posy;
    temp.ID = id;
    return temp;
}

{int, int, int, int} changeAnt(struct Ant ant) {
    ant.positionX++;
    ant.positionY++;
    ant.ID = 1000;
    ant.food--;
    int w = ant.food;
        int x = ant.positionX;
        int y = ant.positionY;
        int z = ant.ID;
        return {w,x,y,z};
}

int main(void) {
    char world[4][3];
    struct Ant ant1;
    struct Ant ant2;
    struct Ant ant3;
    struct Ant ant4;
    initialiseWorld(world);
    ant1 = initAnt(1,0, 1);
    ant2 = initAnt(2,1, 2);
    ant3 = initAnt(2,0, 3);
    ant4 = initAnt(0,1, 4);
    for (int i = 0; i < 2; i++) {
        par {
                ant1 = mve(ant1, world);
                ant2 = mve(ant2, world);
                ant3 = mve(ant3, world);
                ant4 = mve(ant4, world);
           }
    }
    int total = ant1.food + ant2.food + ant3.food + ant4.food;
    printf("%d\n", total);
    printf("%d,%d,%d,%d\n", ant1.food, ant1.positionX, ant1.positionY, ant1.ID);
    {ant1.food, ant1.positionX, ant1.positionY, ant1.ID} = changeAnt(ant1);
    printf("%d,%d,%d,%d\n", ant1.food, ant1.positionX, ant1.positionY, ant1.ID);
    return 0;
}
