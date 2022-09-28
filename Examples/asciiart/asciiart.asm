    maclib ../../CPM/utils
    extrn printstr

    ld de,data
    call printstr
    halt

data:
    incbin bell.data
    db 0