; Copyright (C) 2020  Doctor Volt

 ; This program is free software: you can redistribute it and/or modify
 ; it under the terms of the GNU General Public License as published by
 ; the Free Software Foundation, either version 3 of the License, or
 ; (at your option) any later version.

 ; This program is distributed in the hope that it will be useful,
 ; but WITHOUT ANY WARRANTY; without even the implied warranty of
 ; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ; GNU General Public License for more details.

 ; You should have received a copy of the GNU General Public License
 ; along with this program.  If not, see <https://www.gnu.org/licenses/>.

title 'EEProm disk driver'

base equ $
;Includes
maclib cpm3
maclib z80
maclib utils
maclib syscfg

; General constants
cr	equ 13
lf	equ 10

; Disk drive dispatching tables for linked BIOS
public	promdsk

; Variables containing parameters passed by BDOS
extrn	@adrv,@rdrv,@dma,@trk,@sect,@dbnk

; System Control Block variables
extrn	@ermde		; BDOS error mode

; Utility routines in standard BIOS
extrn	?wboot	; warm boot vector
extrn	?pmsg	; print message @<HL> up to 00, saves <BC> & <DE>
extrn	?pdec	; print binary number in <A> from 0 to 99.
extrn	?pderr	; print BIOS disk error header
extrn	?conin,?cono	; con in and out
extrn	?const		; get console status

;8192 bytes; 1 Track, 8*1024 Byte blocks, sector size 128 byte
dpb$prd: ;Disk Parameter Block https://www.seasip.info/Cpm/format31.html
spt:	dw 	128 ;Number of 128-byte records per track
bsh:	db	3 ;Block shift. 3 => 1k, 4 => 2k, 5 => 4k....
blm:	db	7 ;Block mask. 7 => 1k, 0Fh => 2k, 1Fh => 4k...
exm:	db	0 ;extent mask
dsm:	dw	15 ;(no. of blocks on the disc)-1
drm:	dw	31 ;(no. of directory entries)-1
al0:	db	80h ;Directory allocation bitmap, first byte
al1:	db	00h ;Directory allocation bitmap, second byte
cks:	dw	8000h	;Checksum vector size, 0 or 8000h for a fixed disc.
				;No. directory entries/4, rounded up.
off:	dw	0 ;off - offset for system tracks
psh:	db	1	;Physical sector shift, 0 => 128-byte sectors
				;1 => 256-byte sectors  2 => 512-byte sectors...
phm:	db	1	;Physical sector mask,  0 => 128-byte sectors
				;1 => 256-byte sectors, 3 => 512-byte sectors...	
				
; Extended Disk Parameter Headers (XDPHs)
xdph:
	dw	prd$write
	dw	prd$read
	dw	prd$login
	dw	prd$init
	db	0,0		; unit, type
promdsk:	;Disk Parameter Header (DPH)
	DPH  0, dpb$prd, 0

;cseg

; Init routine called by bootloader.
; returns a=0 on success, a=1 otherwise
prd$init:
	;PRINTLN 'PROM drive init: '
	xra a! ret

prd$login:
	;PRINTLN 'PROM drive selected: '
	ret	

; disk READ and WRITE entry points.

	; these entries are called with the following arguments:
		; relative drive number in @rdrv (8 bits)
		; absolute drive number in @adrv (8 bits)
		; disk transfer address in @dma (16 bits)
		; disk transfer bank	in @dbnk (8 bits)
		; disk track address	in @trk (16 bits)
		; disk sector address	in @sect (16 bits)
		; pointer to XDPH in <DE>

	; they transfer the appropriate data, perform retries
	; if necessary, then return an error code in <A>


; Bios read function
prd$read:
	mvi a,5! out p$zdartCFG$A ;RTSA on: Switch on EEPROM
	mvi a,dart$ra5! ani 0FDh! out p$zdartCFG$A 

	LDED @sect
	mov d,e! mvi e,0 ;e->d
	lxi h,promfs$base! dad d!

	lxi b,256
	LDED @dma
	mvi a,7Fh! cmp d! jm direct$rd ;Jump, if (@dma) is >= 8000h
	;Copy sector from EEPROM to local buffer
	lxi d,sect$buf
	LDIR
	mvi a,5! out p$zdartCFG$A ;RTSA on: Switch off EEPROM
	mvi a,dart$ra5! ori 2! out p$zdartCFG$A 
	lxi b,256		;Copy from local buffer to RAM
	lxi h,sect$buf
	LDED @dma

direct$rd:
		;Copy sector from EEPROM to DMA
	LDIR
	mvi a,5! out p$zdartCFG$A ;RTSA on: Switch off EEPROM
	mvi a,dart$ra5! ori 2! out p$zdartCFG$A 
	xra a!	ret

; write function
prd$write
	lhld @dma 
	mvi a,7Fh! cmp h! jm direct$wr ;Jump, if (@dma) is >= 8000h
	;(@dma) < 8000h; copy to sect$buf first
	lxi d,sect$buf 
	lxi b,256
	LDIR

	;Now copy to EEProm
	lhld @sect 
	mov h,l! mvi l,0 ;l->h is like multiplying with 256 
	lxi d,promfs$base! dad d! ;add to 4000h
	mov d,h! mov e,l  ; EEProm address in DE
	lxi h,sect$buf
	jmp eewrite

direct$wr:
	lhld @sect
	mov h,l! mvi l,0 ;l->h
	lxi d,promfs$base! dad d!
	mov d,h! mov e,l  ; EEProm address in DE
	lhld @dma

eewrite: ; Write 256 byte buffer pointed by HL to EEProm address in DE
	;HEX16 h 
	;PRINT ' -> '
	;HEX16 d 
	;CRLF

	mvi a,5! out p$zdartCFG$A ;RTSA on: Switch on EEPROM
	mvi a,dart$ra5! ani 0FDh! out p$zdartCFG$A 

	push h
    lxi h,5555h! mvi m,0aah ;Write protection off
    lxi h,2aaah! mvi m,55h
    lxi h,5555h! mvi m,80h
    lxi h,5555h! mvi m,0aah
    lxi h,2aaah! mvi m,55h
    lxi h,5555h! mvi m,20h
	pop h

	mvi b,4
	eewrite$lp:
		push b
		lxi b,64
		LDIR
		DLY 10
		pop b
		DJNZ eewrite$lp
    lxi h,5555h! mvi m,0aah ;Write protection on
    lxi h,2aaah! mvi m,055h 
    lxi h,5555h! mvi m,0a0h

	DLY 10 ;Give write protection some time to get active before EEPROM switched off
	;dcr d 
	;DUMP d

	mvi a,5! out p$zdartCFG$A ;RTSA on: Switch off EEPROM
	mvi a,dart$ra5! ori 2! out p$zdartCFG$A 
	xra a! ret

cseg
sect$buf: ds 256

end

