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

title 'PATA disk driver'

;Includes
maclib cpm3
maclib z80
maclib utils
maclib syscfg

;Command block registers
dev$addr  equ p$pata ; Base address A5
reg$data    equ dev$addr+000b ;Data register
reg$err     equ dev$addr+001b ;Read: Error
reg$fr      equ dev$addr+001b ;Write: Features
reg$sc      equ dev$addr+010b ;Sector Count
reg$sn      equ dev$addr+011b ;Sector Number
reg$lba7    equ dev$addr+011b ;LBA Bits 0-7
reg$cylo    equ dev$addr+100b ;Cylinder Low
reg$lba15   equ dev$addr+100b ;LBA Bits 8-15
reg$cyhi    equ dev$addr+101b ;Cylinder High
reg$lba23   equ dev$addr+101b ;LBA Bits 16-23
reg$dh      equ dev$addr+110b ;Drive/Head
reg$lba27   equ dev$addr+110b ;LBA Bits 24-27
reg$status  equ dev$addr+111b ;Read: Status
reg$cmd     equ dev$addr+111b ;Write: Command

;Status flags
BSY     equ 80h ;Drive busy
DRDY    equ 40h ;Drive ready for command
DSC     equ 10h ;Drive head settled over sector
DRQ     equ 08h ;Drive ready for r/w
ERR     equ 1 ;Drive error

;Drive commands
cmd$initpar equ 091h ;Init drive parameters
cmd$read    equ 021h ;Read sector w. retry
cmd$write   equ 031h ;Write sector w. retry
cmd$setfr   equ 0EFh ;Set Features
cmd$diag	equ 090h ;Drive diagnosis

;Drive constants
fr$8bit		equ 01h ;8 Bit data
fr$16bit 	equ 81h ;16 Bit data
mode$lba	equ mode$lba ;LBA mode

; General constants
cr	equ 13
lf	equ 10
ldn equ 2 ; Lowest drive number in @adrv for drives 2: drive c

; Disk drive dispatching tables for linked BIOS
	public	pata0,painit

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

;Macro to compute offset for selected drive: c:0, d:64, e:128, f:192
OFFSET macro
 	lda @adrv ;selected drive number
	sui ldn ;for lowest selected drive number (C:) a shall be 0
	rept 6 ;shift left 6 bytes
		add a
	endm
	endm
	
; Error messages
no$hd: 	db 0
err$init: db 'Error: HD not available',10,13,0
err$dsk:  db 'Drive error',10,13,0
err$lba:  db 'Error: LBA not available',10,13,0
err$rd:   db 'Error: HD cannot be read',10,13,0
err$wr:   db 'Error: HD cannot be written',10,13,0
err$8bit: db 'Error: 8 Bit mode could not be set',10,13,0
err$diag: db 'Error: Drive diagnosis failed',10,13,0
err$para: db 'Error: LBA Mode cannot be set',10,13,0

dpb$pata ;Disk Parameter Block 
	dw 	128 ;(sect$len*?pspt)/128	; spt number of logical 128 - byte records per track
	db	7,127 ;bsh,blm for 16384 bytes blocks - block shift and mask
	db	7 ;exm - extent mask
	dw	03ffh ;dsm - highest block number, number of blocks - 1
	dw	511  ;drm - maximum directory entry number
	db	080h,0  ;al0,al1 - alloc vector for directory
	dw	08000h ;cks - checksum size 08000h permanently mounted
	dw	0 ;off - offset for system tracks
	db	1,1  ;psh,phm - physical sector size shift (Sector len=256 bytes)

; Extended Disk Parameter Headers (XDPHs)
xdph:
	dw	pawrite
	dw	paread
	dw	pa$login
	dw	painit
	db	0,0		; unit, type
pata0:	;Disk Parameter Header (DPH)
	DPH  0, dpb$pata, 0

;dseg
; Init routine called by bootloader.
; returns a=0 on success, a=1 otherwise
painit:
	mvi c, DRDY! lxi h, no$hd! call wait$sr 
	ora a! rnz ;If this went wrong
 	;PRINTLN 'PATA: Drive ready'
	mvi a,ldn! sta @adrv
 	mvi a,0e0h! out reg$lba27 ;LBA mode
	mvi a,cmd$initpar! out reg$cmd
	mvi c,DRDY! lxi h,err$para! call wait$sr
	ora a! rnz ; If this went wrong
	;PRINTLN 'PATA: LBA Mode set'
	;Set 16 Bit data transfer to fill up 512 byte sectors
	mvi a,fr$16bit! out reg$fr 
  	mvi a,cmd$setfr! out reg$cmd
	mvi c,DRDY! lxi h,err$8bit! call wait$sr
	ora a! rnz ; If this went wrong
	;PRINTLN 'PATA: 16-Bit Mode set'
	mvi a,1! out reg$sc
	xra a! ret

pa$login:
	;PRINTLN 'PATA: Drive selected '
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
paread:
	OFFSET
	lhld @sect
	add l ;offset for selected drive
	out reg$lba7
	;PRINT 'PATA: Read Sector: '
	;HEX16 h
	;CRLF
	lda @trk! out reg$lba15 
  	lda @trk+1! out reg$lba23
	;lhld @trk! 
	;PRINT 'Track: '
	;HEX16 h
	;CRLF

	;Issue read command
  	;mvi c,DRDY! ;lxi h,err$rd! ;call wait$sr
  	mvi a,cmd$read! out reg$cmd 
	mvi c,DRQ! lxi h,err$rd! call wait$sr
	ora a! rnz

  	lhld @dma ;DMA addr to <HL>
	;PRINT 'DMA: '
	;HEX16 h
	;CRLF
  	mvi b,0 
  	mvi c,reg$data 
	lhld @dma
	INIR
	ret

; write function
pawrite
	OFFSET
	lhld @sect
	add l ;offset for selected drive
	out reg$lba7
	;PRINT 'PATA: write Sector: '
	;HEX16 h 
	;CRLF
	lda @trk! out reg$lba15 
  	lda @trk+1! out reg$lba23
	lhld @trk! 
	;PRINT 'Track: '
	;HEX16 h
	;CRLF
	;Issue write command
	mvi c,DRDY! lxi h,err$wr! call wait$sr
  	mvi a,cmd$write! out reg$cmd 
  	mvi c,DRQ! lxi h,err$wr! call wait$sr
	ora a! rnz
  	lhld @dma ;DMA addr to <HL>
 	;PRINT 'DMA: '
	;call ?hex16
  	mvi b,0
  	mvi c,reg$data
	OUTIR
	mvi a,0! ret

;wait until BSY falg in PATA status register is cleared
;and at least the flags specified in c are set
;input: reg: c bitmask
;return: d=status reg, e=error reg. or 0 if no error occurred
;<a> = 0 if no error, <a> = 1 on error
wait$sr: 
	mvi b,0 ;256 retries
 wait$sr$loop:
  	in reg$status ;card status
	;HEX8 a
	mov d,a! mvi e,0
  	BIT 0,a ;ERR flag
  	jnz wait$sr$err
  	BIT 7,a ;BSY flag
	jnz wait$sr$wt
	
	ana c! cmp c ;are the required bits in reg b set in a?
	mvi a,0! rz ;then return here
 
 wait$sr$wt: 
  	DLY 10 
	dcr b
	jnz wait$sr$loop

	PRINT 'PATA: Timeout. Status:'
	in reg$status
	HEX8 a 
	CRLF
	xra a! ret
 
 wait$sr$err:
	mov e,a
 	call ?pmsg ;print error message
	mvi a,1! ret ;Something went wrong


end

	jmp foo
	;PRINTLN 'Init PATA drive'
	in reg$status
	ani DRDY
	jz init$wait
	mvi a,1! ret
 init$wait:
	;PRINTLN 'PATA: Waiting...' 
	mvi b,10 ; Number of retries
 bsy$wait:
	DLY 100
	in reg$status
	BIT 0,a ;Error Flag
	jnz drive$error
	BIT 7,a ;BSY flag
	jz disk$ready
	DJNZ bsy$wait
	PRINTLN 'Drive timeout'
	ora a! rnz ; If this went wrong
 foo:
