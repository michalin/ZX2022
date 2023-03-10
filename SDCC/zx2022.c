/*Copyright (C) 2023  Doctor Volt
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <stdlib2.h>
#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <stdint.h>

#define GETCHAR_BUFSIZE 256
uint32_t rand_numbers[32];

void main();

/*Entry point for CP/M. Must be linked to 0x100h*/
void cpm_main()
{
    memcpy(rand_numbers, (void*)0x100, sizeof(rand_numbers)); //Initialize random generator with first 32 dword values from calling program
    main();
    __asm 
    jp 0
    __endasm;
}

/*Declared in stdio.h*/
int getchar(void)
{
    static uint16_t wr_ptr = 0;
    static uint16_t rd_ptr = 0;
    static char buffer[GETCHAR_BUFSIZE];
    if(wr_ptr == 0)
    {
        do
        {
            buffer[wr_ptr] = _getch();
            putchar(buffer[wr_ptr]);
        } while(buffer[wr_ptr++] != CR && wr_ptr <= GETCHAR_BUFSIZE);
        putchar(CRLF); //newline
    }
    uint16_t retval = (int)buffer[rd_ptr++];
    if(rd_ptr == wr_ptr) 
    {
        rd_ptr = wr_ptr = 0;
        retval = CRLF; // newline
    }
    return retval;
}

int putchar(int ch)
{
    return putch(ch);
}

/*Declared in conio.h*/
_Bool _kbhit() __naked
{
    __asm 
    ld c,#6 // BDOS FUNCTION 6: Direct console I/O
    ld e,#0xFE; //Return a character without echoing if one is waiting; zero if none is available
    call 5     // BDOS
    ret
    __endasm;
}

int _getch() __naked
{
    __asm 
    ld c,#6 //BDOS FUNCTION 1: Direct Console IO
    ld e,#0xFD; //[CP/M3, DOS+] Wait until a character is ready, return it without echoing.
    call 5     //BDOS
    ld e,a 
    ld d,#0
    ret
    __endasm;
}

int _putch(int c) __naked
{
    c;
    __asm
    push hl //Save on stack for later return
    push hl //Save on stack for later comparison with newline character (10d)
    ld c,#2; // BDOS FUNCTION 2: CONSOLE OUTPUT
    ld e,l 
    call 5 // BDOS

    pop hl 
    ld a,l
    cp #CRLF ;Last received character a newline?
    jp nz,00001$ ;If no jump to end 
    ld c,#2; // BDOS FUNCTION 2: CONSOLE OUTPUT
    ld e,#CR ;If yes write additional CR to console
    call #5 // BDOS

    00001$: //End of function
    pop de //Return value
    ret 
    __endasm;
} 

void _clrscr()
{
    putchar(27);
    printf("[H"); //Home of cursor
    putchar(27); //ESC
    puts("[J"); //Clear screen
}

/*Declared in stdlib2.h*/
int system(const char* command)
{
    if(!strcmp(command,"cls"))
    {
        clrscr();
    }
    else if(!strcmp(command,"home"))
    {
        putchar(27);
        puts("[H"); //Home of cursor
    }
    return 0;
}

void exit(uint16_t jump) __naked
{
    jump;
    __asm 
    jp (hl)
    __endasm;
}

#define MAT0POS(t,v)  (v ^ (v >>  (t)))
#define MAT0NEG(t,v)  (v ^ (v << -(t)))
int rand(void) 
{
    static int i = 0;
    const uint8_t M1 = 3;
    const uint8_t M2 = 24;
    const uint8_t M3 = 10;
    const uint8_t R = sizeof(rand_numbers)/sizeof(uint32_t);
    uint32_t z0 = rand_numbers[(i+R-1) % R];
    uint32_t z1 = rand_numbers[i]^MAT0POS(+8, rand_numbers[(i+M1) % R]);
    uint32_t z2 = MAT0NEG(-19,rand_numbers[(i+M2) % R]) ^ MAT0NEG (-14,rand_numbers[(i+M3) % R]);
    rand_numbers[i] = z1 ^ z2;
    rand_numbers[(i+R-1) % R] = MAT0NEG (-11,z0) ^ MAT0NEG (-7,z1) ^ MAT0NEG (-13,z2);
    i = (i + R - 1) % R;
    return rand_numbers[i] & RAND_MAX; //Only positive values between 0 and 32767
}

/*declared in unistd.h*/
void msleep(int ms) __naked
{
    ms;
    __asm
    ld bc,#0
    00001$:

    ld a,#230 ;Change for clock frequencies different from 6 MHz
    00002$: ;This loop takes one millisecond
    nop
    nop
    nop ;waste some time
    dec a  
    jp nz,00002$ ;Loop until a=0

    dec hl ;Input value ms in hl 
    sbc hl,bc
    jp nz,00001$

    ret 
    __endasm;
     
}

int sleep(uint16_t s)
{
    do {
        msleep(1000);
    } while(--s);
    return s;

}

/*    
    char dartcfg[] = {0,0x18,1,0x80,3,0xC1,4,0x84,5,0x68,255};
    int i = 0;
    while(dartcfg[i] != 255) 
    {
        dartAcfg = dartcfg[i++];
    } 
    
        int j = 10 * milliseconds;
    for (int i = 0; i < j; i++)
    {
        for (int k = 0; k < 8; k++)
            ;
    }

*/