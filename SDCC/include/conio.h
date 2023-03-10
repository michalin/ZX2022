
#ifndef CONIO_H
#define CONIO_H
#define CR 13 //Carriage return (\r)
#define LF 10 //New line character for console without CR
#define CRLF 10  //New line character C (\n)
#define getch _getch    //Get char entry from the console 
#define kbhit _kbhit    //Determines if a keyboard key was pressed
#define putch _putch    //Writes a character directly to the console
#define clrscr _clrscr  //Clears the screen
/* TODO:
cgets 	Reads a string directly from the console
cscanf 	Reads formatted values directly from the console
cputs 	Writes a string directly to the console
cprintf 	Formats values and writes them directly to the console
getch 	
*/

int system(const char* command);
_Bool _kbhit();
int _getch();
int _putch(int);
void _clrscr();
#endif

