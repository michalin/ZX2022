; Macro to print out text
PRINT MACRO ?prn
	local ?prnt,?msg,?lp
	jmp ?prnt
	?msg db ?prn,0
 ?prnt:
	push af! push hl
	ld hl,?msg
    ld c,p$zdart$A
  ?lp:
    outi
    ld a,(hl)! or a! jp nz,?lp
	pop hl! pop af'
	ENDM
; Carriage return & Line feed

CRLF MACRO
	local ?prnt,?break
	jmp ?prnt
	?break db 10,13,0
 ?prnt:
	PRINT <10,13>
	ENDM

PRINTLN MACRO ?prn
	PRINT ?prn
	CRLF
	ENDM

    maclib syscfg

    ;Variables in common memory starting at 0x8000
    biosbase equ 08000h 
    biossize equ 08002h 
    biostop equ 08004h 
    bdosbase equ 08006h
    krnlsize equ 08008h 
    

    ld sp,0FFFFh
    ; Init DART
    ld c,p$zdartCFG$A 
    ld b,dart$cfg$end-darta$cfg
    ld hl,darta$cfg
    otir
    ;jp memtest
    PRINT <27,'[2J',27,'[H'> ;Clear terminal screen, Cursor to home position
    PRINTLN 'ZX 2022 Bootloader V2.0 (c) Doctor Volt'
    PRINTLN 'CP/M Load addresses:'
    CRLF
    PRINTLN '*************************'
    ;Get load adresses of Kernel
    ld de,biosbase! ld hl,kernel+091h ;Base addr of BIOS
    call ?str2hex
    ld hl,(biosbase)
    PRINT '* BIOS START: 0x'! call hex16! CRLF

    ld de,bdosbase! ld hl,kernel+0ach ;Base addr of BDOS
    call ?str2hex
    ld hl,(bdosbase)
    push hl
    PRINT '* BDOS START: 0x'! call hex16! CRLF
    pop hl
    ;ld a,0C3h! ld (tmpbdos),a ;JP **
    ;ld bc,6! add hl,bc! ld (tmpbdos+1),hl ;temporary BDOS jump vector

    ld de,biossize! ld hl,kernel+097h ;BIOS size
    call ?str2hex ;Size of BIOS in DE
    ld hl,(biosbase)
    ld bc,(biossize)
    add hl,bc ;add BIOS base and BIOS size
    ld (biostop),hl ;store result in bistop
    PRINT '* TOP: 0x'! call hex16! CRLF

    ld hl,(biostop)
    ld bc,(bdosbase)
    adi 0; this resets the carry flag
    sbc hl,bc ;BIOS Top - BDOS Base 
    ld (krnlsize),hl
    PRINT '* KERNEL SIZE: 0x'! call hex16! CRLF
    PRINTLN '*************************'
    ;Now copy chunks of 128 byte in reverse order to common RAM area

    ld hl,(bdosbase)! ld bc,127! add hl,bc! ld d,h! ld e,l ;destination in RAM ->de
    ld hl,kernel+255! ld bc,(krnlsize)! add hl,bc ;Top of cpm3.sys in ROM -> hl
 
    ld a,(krnlsize+1)! add a ;Number of 128 byte chunks 
copy$loop:
    ld bc,128 ;Copy chunks of 128 bytes
    lddr ;(hl)->(de), hl=hl-128, de=de-128
    inc d ;next chunk
    dec a! jp nz,copy$loop
biosstart: ;Jump to CP/M BIOS in Ram
    ld hl,(biosbase)
    jp (hl)

memtest:
    PRINT <27,'[2J',27,'[H'> ;Clear terminal screen, Cursor to home position
    PRINTLN 'Performing memory test'
   ; call hex16
   ; ld hl,0! ld de, 08000h! ld bc,01000h
   ; ldir
   ; call 08000h
    halt


  	ld a,5! out (p$zdartCFG$A),a
	ld a,dart$ra5! or 080h! out (p$zdartCFG$A),a



darta$cfg:
    db 0, 00011000b     ;wr0, channel reset
    db 1, dart$ra1     ;wr1, halt CPU until character sent
    db 3, dart$ra3     ;wr3, Rx 8 Bit, receive enable
    db 4, dart$ra4     ;wr4, X32 Clock, No Parity, one stop bit
    db 5, dart$ra5     ;wr5, Tx 8 Bit, transmit enable
dart$cfg$end equ $

;
; Auxiliary functions
;
; Print out a 16-Bit HEX value
; Input value in <hl>
hex16:
    push af
    push hl
    ld a,h
    call hex8
    pop hl! ld a,l
    call hex8
    pop af
    ret

; Input value in <a>
hex8:
    push af! push bc
    ld b,a
    rra! rra! rra! rra  
    call hex4
    ld a,b
    call hex4
    ld a,b
    pop bc! pop af
    ret
    ;inval: ds 1

hex4:
    and 0fh! cp 10 ; >=10
    jp p,a2f 
    add 48 ;output 0-9
    jp ot
 a2f: 
    add 55 ;output a-h
 ot:
   out (p$zdart$A),a
   ret

;Convert a byte string into a hex number
;Input: <hl> Start addr of string, <de> Start addr of result (16 bit word)
;After execution, the address pointed to by DE contains a hex number
?str2hex:
    ld b,2
    inc de
 s2h$lp:
    ld a,(hl)! inc hl
    call ?c2hex
    add a! add a! add a! add a! ;Shift left 4 bytes
    ld c,a ;Upper 4 bits
    ld a,(hl)! inc hl
    call ?c2hex
    add c
    ld (de),a 
    dec de
    djnz s2h$lp
    ret
?c2hex: ;Convert Single character in <a> to hex value
    cp 65 ;'character A'
    jp m,deci
    sbc 55 ;A-F
    ret
 deci: 
    sbc 47 ;1-9
    ret

    org 0400h
kernel equ $

