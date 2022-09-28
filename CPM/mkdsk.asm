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

    title 'ZX-2022 disk formatter'

    maclib utils
    extrn hex4

    PRINTLN 'ZX-2022 Disk formatter V1.0'
    RETDSK ; From which disk started?
    cp 1! jp z,check
    PRINTLN 'This program must be started from drive B> (Serial disk)'
    jp 0
; Hard drive available?
check:
    SETERMDE 0FFh ;Return Error mode
   	SELDISK 2
	or a! jp z,format ;Drive selected
    PRINTLN 'No hard drive found'
    jp 0

format: 
    PRINT 'Format disk. All data will be lost. Sure? (y/n) '
    READKEY '>'
    cp 'y'! jp nz,0
    call initb
    call cpyccp
    CRLF
    PRINTLN 'Ready. To copy the CP/M files to drive C> enter "pip c:=*.*"'
    jp 0


initb:
    PRINTLN 'writing directory block, please wait.'
    ;Select drive C:
    ld c,2! call ?sldsk
    call ?home

 ;fill DMA buffer with 0xE5
    ld b,0! ld hl,DMA
    ft$fill$dma:   
    ld (hl), 0E5h! inc hl
    djnz ft$fill$dma

 ;Fill sectors of track 0 
    lxi b,DMA! call ?stdma
    ld b,0! ld hl,0 
    ft$writeall:
        push bc! push hl
        ld b,h! ld c,l! call ?stsec
        call ?write
        pop hl! inc hl! pop bc
        djnz ft$writeall

    ld c,0! call ?sldsk
    ret

cpyccp:
    SETERMDE 0
    PRINTLN 'Copying ccp to C-F>'

;copy system files from A: to C:
copy$file:  
    SELDISK 1  ;Load CCP from drive B to DMA
    PRINTLN 'Reading CCP from B>'
    OPEN ccp$srcfcb
    STDMA DMA
    SETMULTI 32
	READSEQ ccp$srcfcb	; load the thing
    CLOSE ccp$srcfcb
    ld hl,ccp$dstfcb+10! ld a,(hl)! or 80h ;Set system attribute of FCB
    ld (hl),a

    ld b,4! ld e,'C'
 cf$wrloop: ;Write to drive C-F
    push bc! push de
 	
    PRINT 'Writing CCP to '
    ld c,6! call bdos ;Output drive letter in reg. e
    PRINTLN '>'
    pop de
    call wr$ccp
    inc e ;next drive letter
    pop bc
    djnz cf$wrloop
    PRINTLN 'Drive is ready to use. To copy CP/M files type "pip c:=*.*" '
    jp 0 ;back to OS

 wr$ccp:
    push de
    ld a,e! ld e,'A'! sub e ;Calculate drive number from drive letter
    ld e,a
	mvi c,14! call bdos ;Change directory to number in reg. e
    MAKE ccp$dstfcb
    SETATTR ccp$dstfcb
    STDMA DMA
    SETMULTI 32
    WRITESEQ ccp$dstfcb 
    CLOSE ccp$dstfcb
    ;ld hl,ccp$dstfcb
    ;DUMP h,2
    pop de
    ret

; Redirection functions to BIOS calls
?home:
    ld a,8! ld (bp$func),a
    ld c,50! lxi d,biospb
    jp bdos

?sldsk:
    ld a,9! ld (bp$func),a
    ld a,c! ld (bp$bcreg),a
    ld a,0! ld (bp$bcreg+1),a
    ld c,50! lxi d,biospb
    jp bdos

?stsec:
    ld a,11! ld (bp$func),a
    ld a,c! ld (bp$bcreg),a
    ld a,b! ld (bp$bcreg+1),a
    ld c,50! lxi d,biospb
    jp bdos

?stdma:
    ld a,12! ld (bp$func),a
    ld a,c! ld (bp$bcreg),a
    ld a,b! ld (bp$bcreg+1),a
    ld c,50! lxi d,biospb
    jp bdos

?write:
    ld a,14! ld (bp$func),a
    ld c,50! lxi d,biospb
    jp bdos

DSEG

;Parameters to be passed to BIOS functions
biospb:
    bp$func ds 1
    bp$areg ds 1
    bp$bcreg ds 2
    bp$hlreg ds 2

ccp$srcfcb:
    db 0,'CCP     ','COM'
    dw 0,0,0,0,0,0,0,0,0,0,0,0

ccp$dstfcb:
    db 0,'CCP     ','COM'
    dw 0,0,0,0,0,0,0,0,0,0,0,0

cur$fcb ds 36

DMA: db 0 ;use TPA after program for file exchange
end    

