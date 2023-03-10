#
# Makefile for SDCC

CAT=srec_cat.exe 
SDCC=sdcc.exe -mz80 --no-std-crt0 -I include 
LINK=sdldz80 -nf
CPMPATH =../CPM

RM=del -f
CONCAT = copy /b
CP=copy 

all: $(src).com

zx2022.rel: zx2022.c
	$(SDCC) -c zx2022.c 

$(src).com: zx2022.rel $(src).c
	$(SDCC) -c $(src).c -o source.rel
	$(LINK) zx2022.lk
	$(CAT) zx2022.ihx -intel -offset=-0x100 -o $(src).com -binary

clean:
	$(RM) *.ihx *.map *.noi source.rel *.lst *.sym zx2022.asm source.asm

