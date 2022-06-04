IF !DEF(DEBUG_INC)
DEBUG_INC=1

INCLUDE "hardware.inc"

; Prints a message to the no$gmb / bgb debugger
; Accepts a string as input, see emulator doc for support
DBGMSG: MACRO
    ld d, d
    jr .end\@
    DW $6464
    DW $0000
    DB \1
.end\@:
    ENDM

; Breaks when called
DBGSTOP: MACRO    
    xor a
    ldh [rIE], a    
    di
    halt
    ENDM


ENDC ; DEBUG_INC