#
# Makefile for CP/M 3
ZXCC=zxcc.exe
RMAC=../bin/rmac.exe
LINK=../bin/drilink.exe
ZMAC=../bin/zmac.exe  --rel --dri --od ./
RUN=../bin/romldr.exe

RM=del -f
CP=copy 

BDOS_SOURCES= CPMBDOS1.ASM CONBDOS.ASM BDOS30.ASM

all: rom.img

cpm3.sys: bdos3.spr bios3.spr gencpm.dat
	$(ZXCC) gencpm auto 
	@echo *

rom.img: cpm3.sys bootldr.com
	copy /b bootldr.com+cpm3.sys rom.img	

bootldr.com: bootldr.asm syscfg.lib
	$(ZMAC) bootldr.asm
	$(LINK) bootldr[L0] 

bios3.spr: bioskrnl.rel scb.rel boot.rel chario.rel drvtbl.rel move.rel promdsk.rel serdisk.rel pata.rel utils.rel vdp.rel isrtbl.rel 
	$(LINK) BIOS3[OS]=bioskrnl,scb,boot,chario,drvtbl,move,promdsk,serdisk,pata,utils,vdp,isrtbl

# BIOS Modules
bioskrnl.rel: bioskrnl.asm
	$(RMAC) bioskrnl.asm
boot.rel: boot.asm syscfg.lib
	$(ZMAC) boot.asm 
chario.rel: chario.asm syscfg.lib
	$(ZMAC) chario.asm
drvtbl.rel: drvtbl.asm
	$(RMAC) drvtbl.asm
isrtbl.rel: isrtbl.asm
	$(ZMAC) isrtbl.asm
move.rel: move.asm
	$(RMAC) move.asm
pata.rel: pata.asm syscfg.lib
	$(RMAC) pata.asm 
promdsk.rel: promdsk.asm syscfg.lib
	$(RMAC) promdsk.asm
scb.rel: scb.asm
	$(RMAC) scb.asm
serdisk.rel: serdisk.asm
	$(RMAC) serdisk.asm
vdp.rel: vdp.asm syscfg.lib
	$(ZMAC) vdp.asm

# BDOS
bdos3.spr: BDOS3.ASM
	$(RMAC) BDOS3.ASM
	$(LINK) BDOS3[OS]=BDOS3

# Utilities

mkdsk: utils.rel chario.rel vdp.rel
	$(ZMAC) mkdsk.asm 
	$(LINK) mkdsk,utils
	$(CP) mkdsk.com serdisk\0

utils.rel: utils.asm
	$(ZMAC) utils.asm

trmtest:
	$(ZMAC) trmt.asm 
	$(LINK) trmt,utils
	$(CP) trmt.com serdisk\0


clean:
	$(RM) *.prn *.rel *.spr *.sym *.sys *.sbin *.lst xxprog.* 

