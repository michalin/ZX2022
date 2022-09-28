#
# Makefile for Example

BINPATH=../../bin
LINK=$(BINPATH)/drilink.exe
ZMAC=$(BINPATH)/zmac.exe  --rel --dri --od ./
CPMPATH =../../CPM
ASMNAME=asciiart

RM=del -f
CP=copy 

all: $(ASMNAME).com

$(ASMNAME).com: $(ASMNAME).asm utils.rel
	$(ZMAC) $(ASMNAME).asm
	$(LINK) $(ASMNAME),utils

utils.rel: 
	$(ZMAC) $(CPMPATH)/utils.asm

clean:
	$(RM) *.rel *.sym *.sys *.lst xxprog.*


