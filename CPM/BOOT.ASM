	title	'Boot loader module for CP/M 3.0'

true equ -1
false equ not true

	;public	?ldccp,?rlccp,?time
	extrn	?pmsg,?conin,?sldsk, ?paread, ?pawrite
	extrn	@civec,@covec,@aivec,@aovec,@lovec,@scbbase,@dtbl
	extrn 	@dma, @sect

	extrn ?cinit			; (re)initialize device in <C>
	extrn painit			; CF drive
	extrn ?irqinit			; Init interrupts
	maclib syscfg
	maclib utils

	bdos	equ 5
;dseg	
?init::

	ld hl,0A000h ! ld (@civec),hl ! ld (@covec),hl	; assign console to CRT:
	ld hl,00000h ! ld (@lovec),hl 			;
	ld hl,08000h ! ld (@aivec),hl ! ld (@aovec),hl	; assign AUX to CRT1:

	call ?irqinit
	ld c,0! call ?cinit
	ld c,1! call ?cinit ;PS/2 Keyboard
	;Switch 0x0-0x7FFF from EEPROM to SRAM (Pull RTSA low)
	ld a,5! out (p$zdartCFG$A),a

	ld a,dart$ra5! or 02h! out (p$zdartCFG$A),a
	ld c,2! call ?cinit ;Init VDP if p$vdp in syscfg.lib is not 0

	PRINTLN 'ZX 2022 CP/M 3.1. Have fun.'		; print signon message

;Check for PATA drive
	PRINT 'Looking for hard drive... '
	call painit
	;a=0: HD found, a=1: HD not found or HD error
	or a! jp nz,no$hd
	PRINTLN 'found.'
	ret
no$hd:
	PRINTLN 'not found'
	;Erase drive entries for drives C-F in @dtbl
	ld b,8! ld hl,@dtbl+4 ;Starting at word 2/drive C:
	 	owdrv:
	 	ld (hl),0! inc hl
		djnz owdrv
	ret

;Load ccp from active drive
?ldccp::
	;PRINTLN 'ldccp'
	xor a! ld (search$fcb+15),a! ld (search$fcb+32),a		; zero ex and cr
	SELDISK 0
	SEARCHF search$fcb ;Is there a .com file on the EEPROM disk?
	inc a! jp z,ldccpB ;If there is no .com file or unformatted
	ld hl,80h! ld de,search$fcb! ld bc,32! ldir ;copy fcb
	OPEN search$fcb 
	STDMA 100h		;start of TPA
	SETMULTI 128		;allow up to 16k bytes
	READSEQ search$fcb	;load the thing
	CLOSE search$fcb
	ret

  ldccpB: ;Search for ccp.com on serial disk
	;PRINTLN 'ldccpB'
	SETERMDE 0ffh ;Return error  
	SELDISK 1
	or a! jp nz,ldccpC ;Drive cannot be selected
	call ldccp$com
	or a! jp z,ldccpC
	ld a,1! ld (@scbbase+013h),a ;Set drive B in CCP
	ret

  ldccpC: ;Search for ccp.com on CF Card
	;PRINTLN 'ldccpC'
	;xor a! ld (ccp$fcb+15),a! ld (ccp$fcb+32),a		; zero ex and cr
	SELDISK 2
	call ldccp$com 
	or a! jp z,no$ccp ;If not found
	ld a,2! ld (@scbbase+013h),a ;Set drive C in CCP
	ret

  ldccp$com: ;Load the CCP. returns 0, if not found
	;PRINTLN 'ldccp$com'
	xor a! ld (ccp$fcb+15),a! ld (ccp$fcb+32),a		; zero ex and cr
	OPEN ccp$fcb	
	inc a! ret z ;CCP Not found
	STDMA 100h		
	SETMULTI 32		
	READSEQ ccp$fcb	
	CLOSE ccp$fcb
	ld a,1! ret

  no$ccp:
	PRINTLN 10,13,'No CCP.COM file found.'
	PRINTLN 'Connect serial disk and click Reset'
	call ?conin			; get a response
	jp 0 ;Reboot
	;call ldccpB			; and try again
	;ret
    ; No external clock.

?rlccp:: 
	;PRINTLN 'rlccp'
 	RESETD
	ld hl,search$fcb! xor a! ld(hl),a
	jp ?ldccp 

?time::
	ret
	; CP/M BDOS Function Interfaces

initmem:
	ld hl,7FFFh
	ld bc,1
  clram:
	ld(hl),0
	sbc hl,bc
	jp nz, clram
ret


;Data
dseg
ccp$fcb:	db	0,'CCP     ','COM' 
			ds	20
search$fcb: db	0,'????????','COM'
			ds	20
end

