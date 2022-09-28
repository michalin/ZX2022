    maclib ../../CPM/syscfg
    maclib ../../CPM/utils


    call vdp_init3

init$nt: ;Initialize Name table with successive numbers (1,2,3,4,5,...,0FFh)
    ld hl,ntbl! call vdp_vram_wraddr ;Set video RAM address to name table
    ld hl,0! ld de,768! ld b,0
    init$nt$lp:
        ld a,b 
        ;HEX8 a
        out (p$vdp),a 
        inc a! inc hl
        ld b,a
        ld a,l! cp e! jp nz,init$nt$lp
        ld a,h! cp d! jp nz,init$nt$lp


    ld hl,ptbl! call vdp_vram_wraddr ;Set video RAM address to pattern table
    ld hl,0! ld de,1800h! ld bc,pat+7
    init$pt$lp:
        ld a,(bc)! inc bc
        out (p$vdp),a 
        inc hl
        ld a,l! cp e! jp nz,init$pt$lp
        ld a,h! cp d! jp nz,init$pt$lp

    ld hl,ctbl! call vdp_vram_wraddr ;Set video RAM address to pattern table
    ld hl,0! ld de,1800h! ld bc,col+7
    init$ct$lp:
        ld a,(bc)! inc bc
        out (p$vdp),a 
        inc hl
        ld a,l! cp e! jp nz,init$ct$lp
        ld a,h! cp d! jp nz,init$ct$lp

    halt

; Init graphic mode 3
vdp_init3:
    ;Flush VRAM

    ld c,p$vdp+1
    ld b,vdp$cfg$end-vdp$cfg
    ld hl,vdp$cfg
    otir 

    ;Flush 16k of VRAM starting at 0
    ld hl,0! call vdp_vram_wraddr
    ld a,0h! ld hl,4000h! ld bc,1
    flush:
        out (p$vdp),a
        nop
        sbc hl,bc
        jp nz,flush
    ret

; Write VDP register: Number in c, value in a
vdp_wr_reg:
    out (p$vdp+1),a ;Write data 
    ld a,80h! or c 
    out (p$vdp+1),a
    ret

; Read VDP register 0: Returns value in a
vdp_rd_reg:
    in (p$vdp+1)
    ret

; Set first VRAM write address in hl. 
vdp_vram_wraddr:
    push a
    ld a,l! out (p$vdp+1), a ;Start addr., LSB
    ld a,h! or 0x40! out (p$vdp+1), a ;Start addr. MSB + 0x40
    pop a
    ret

; Set first VRAM read address in hl. 
vdp_vram_rdaddr
    push a
    ld a,l! out (p$vdp+1), a ;Start addr., LSB
    ld a,h! out (p$vdp+1), a ;Start addr. MSB + 0x40
    pop a
    ret

vdp$cfg:
    reg0: db 02h,80h   ;Graphic mode 2, no external VDP input:
    reg1: db 0C0h,81h   ;16k, no interrupt, Graphic mode 2, sprite 8x8, MAG 0
    reg2: db 0Eh,82h    ;Name table at 3800h
    reg3: db 0FFh,83h    ;Color table, start at 0x2000 
    reg4: db 03h,84h    ;Pattern table start at 0x0 
    reg5: db 76h,85h    ;Sprite attriutes start at 0x3B00 
    reg6: db 03h,86h    ;Sprite pattern table at 0x1800 
    reg7: db 01h,87h    ;Backdrop color
    vdp$cfg$end equ $

ntbl equ 3800h  ;Name table start
ptbl equ 0      ;Pattern table start
ctbl equ 2000h  ;color table start

pat:
   incbin simpsons.pat 
pat$end
col:
    incbin simpsons.col
col$end