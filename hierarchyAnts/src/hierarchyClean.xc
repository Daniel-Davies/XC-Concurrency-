/*
 * hierarchyClean.xc
 *
 *  Created on: 9 Oct 2017
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

void initialiseWorld(int new[4][3]) {
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

struct Ant mve(struct Ant ant, int world[4][3]) {
    int eastMove = world[(ant.positionX+1)%4][(ant.positionY)];
    int sothMove = world[(ant.positionX)][(ant.positionY+1)%3];
    if (eastMove > sothMove) {
        ant.positionX =(ant.positionX + 1) % 4;
    }
    else {
        ant.positionY = (ant.positionY +1) % 3;
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

struct Ant superiorProcess(struct Ant antq, chanend no1, chanend no2, int world[4][3]){
    int queen1Resp;
    int queen2Resp;

    no1 :> queen1Resp;
    no2 :> queen2Resp;

    if (queen1Resp > queen2Resp) {
        no1 <: 1;
        no2 <: 0;
    }
    else {
        no1 <: 0;
        no2 <: 1;
    }
    return antq;
}

struct Ant queenProcess(struct Ant antq, chanend no1, chanend no2, chanend no3, int world[4][3]){
    int incomingAnt1;
    int incomingAnt2;
    no1 :> incomingAnt1;
    no2 :> incomingAnt2;
    int totalHarvest = incomingAnt1 + incomingAnt2;
    no3 <: totalHarvest;
    int command;
    no3 :> command;
    if (command == 1) {
        if (incomingAnt1 > incomingAnt2) {
                no1 <: 0;
                no2 <: 1;
            }
            else {
                no1 <: 1;
                no2 <: 0;
            }
    }
    else {
        no1 <: 1;
        no2 <: 1;
    }
    return antq;
}

struct Ant workerProcess(struct Ant ant, chanend c, int world[4][3]) {
    c <: world[ant.positionX][ant.positionY];
    int directive;
    c :> directive;
    if (directive == 0) {
        ant.food = ant.food + world[ant.positionX][ant.positionY];
    }
    else {
        for (int i = 0; i < 2; i++) {
            ant = mve(ant, world);
        }
    }
    return ant;
}

void antHill(chanend overwatchComm) {
    struct Ant ant1;
    struct Ant ant2;
    struct Ant antq;
    struct Ant antSup;
    chan comm[2];
    ant1 = initAnt(1,0, 1);
    ant2 = initAnt(0,1, 2);
    antq = initAnt(1,1, 100);
    antq = queenProcess(antq, comm[0], comm[1], overwatchComm, world);
    ant1 = workerProcess(ant1,comm[0], world);
    ant2 = workerProcess(ant2,comm[1], world);
}



int main(void) {
    int world[4][3];
    int antHillNum;
    antHillNum = 2;
    chan overwatch[antHillNum];
    for (int i = 0; i < 2; i++) {
        par {
            antHill()
         }
        printf("****************************************\n");
        printf("ANT1- food: %d locations: (%d, %d)\n", ant1.food, ant1.positionX, ant1.positionY);
        printf("ANT1- food: %d locations: (%d, %d)\n", ant2.food, ant2.positionX, ant2.positionY);
        printf("ANT1- food: %d locations: (%d, %d)\n", ant3.food, ant3.positionX, ant3.positionY);
        printf("ANT1- food: %d locations: (%d, %d)\n", ant4.food, ant4.positionX, ant4.positionY);
    }
    int total = ant3.food + ant4.food + antq.food;
    printf("%d\n", total);
    printf("%d,%d,%d,%d\n", ant1.food, ant1.positionX, ant1.positionY, ant1.ID);
    {ant1.food, ant1.positionX, ant1.positionY, ant1.ID} = changeAnt(ant1);
    printf("%d,%d,%d,%d\n", ant1.food, ant1.positionX, ant1.positionY, ant1.ID);
    return 0;
}
