/* Include this header file instead of stdlib.h if additional functions which are not 
included in SDCC's stdlib header are nedded */

#ifndef STDLIB_H
#define STDLIB_H
#include <stdlib.h>
void exit(unsigned short int jump); //Parameter is the jump address after execution

#endif