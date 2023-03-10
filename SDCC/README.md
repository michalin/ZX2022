# Adaptions for SDCC (Small Device C compiler)

[SDCC](https://sdcc.sourceforge.net) is a cross compiler for Windows or Linux that can also generate Z80 code. It generates an Intel HEX file (*.ihx). Use [srec_cat](http://sourceforge.net/projects/srecord) to convert this to a binary file that can be uploaded to the ZX2022 by the loader app. [zx2022.c](zx2022.c) contains platform specific IO functions like printf and others, that are not implemented in the SDCC Z80 library. [worm.c](worm.c) is a simple worm/snake game that serves as an example.

### Compiling the example
To compile the "worm.c" example source file, type on the command line:  
`sdcc -mz80 --no-std-crt0 -I include -c worm.c -o source.rel`

If it is necessary to compile zx2022.c to get zx2022.rel, type:  
`sdcc -mz80 --no-std-crt0 -I include -c zx2022.c`

To link the *.rel files:  
`sdldz80 -nf zx2022.lk`

To convert the Intel Hex file "worm.ihx" to a CP/M executable:  
`srec_cat zx2022.ihx -intel -offset=-0x100 -o worm.com -binary`

For your convenience, you can call the makefile (GNU make utility required):  
`make src=worm`

For more information about complier options, refer to the documentation
