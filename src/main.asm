; -----------------------------------------------------------------------------
; Main file
; -----------------------------------------------------------------------------
;
INCLUDE "hardware.inc"
;
DEF DEBUG_ENABLED EQU 1 ; set to 0 to remove ld d, d debug messages
INCLUDE "debug.inc"
;
INCLUDE "tiles.inc"
;

; INT 40 - VBlank interrupt handler
; ------------------------------------------------------------------------------
; Increase frame counter, DMA shadow OAM to OAM and wake main game loop
SECTION "INT40_VBlank",ROM0[$0040]
INT40_VBlank:	    
    push hl
    ld hl, CurrentFrameAsync		
    inc [hl]    
    jp DmaSub
.end

; Rest of INT 40 - VBlank interrupt handler is copied into HRAM at start due to DMA
SECTION "DmaSubCode", ROMX
DmaSubCode:
    pop hl
    push af	
    ld	a, $C0
    ld [rDMA], a
    ld a, 40
.copy
    dec a
    jr nz, .copy    
    pop af
    DBGMSG "VBlank"
    reti	
.end
    
; INT 48 - STAT interrupt handler
SECTION "INT48_Stat",ROM0[$0048]	
INT48_Stat:
    DBGSTOP
.end

; INT 50 - Timer interrupt handler
SECTION "INT50_Timer",ROM0[$0050]
INT50_Timer:	
    DBGSTOP
.end	

; INT 58 - Serial interrupt handler
SECTION "INT58_Serial",ROM0[$0058]
INT58_Serial:
    DBGSTOP
.end

; INT 60 - Joypad interrupt handler
SECTION "INT60_Joypad",ROM0[$0060]
INT60_Joypad:    
    DBGSTOP
.end

; Entry point (4 bytes)
SECTION	"Start",ROM0[$0100]	
    jp	Main	

; Main function
SECTION "Main",ROM0[$0150]
Main:
    di
    ld	sp, Stack.end

    ; Wait for vertical blank to properly turn off display
    .wait_vbl					
    ld	a,[rLY]	
    cp	$90
    jr	nz,.wait_vbl

    ; Reset I/O registers
    xor	a
    ld	[rIF],a
    ld	[rLCDC],a
    ld	[rSTAT],a
    ld	[rSCX],a
    ld	[rSCY],a
    ld	[rLYC],a

    ; Setup PALETTE
    ld	a,%10010011			; bits: 7-6 = 1st color, 5-4 = 2nd, 3-2 = 3rd and 1-0 = 4th color
                            ; color values: 00 - light, 01 - gray, 10 - dark gray, 11 - dark
    ld	[rBGP],a			; bg palette
    ld	[rOBP0],a			; obj palettes (not used in this example)
    ld	[rOBP1],a

    ; copy dma sub into hram
    ld	c, $80						; dma sub will be copied to _HRAM, at $FF80
    ld	b, DmaSubCode.end - DmaSubCode
    ld	hl, DmaSubCode
.copy
    ld	a, [hli]
    ld	[c], a
    inc	c
    dec	b
    jr	nz,.copy	

    ; zero shadow oam
    ld hl, ShadowOam
    ld b, ShadowOam.end - ShadowOam
    xor a
.zero
    ld [hli], a
    dec b
    jr nz, .zero

    ; copy tiles into video ram
    ld	hl, Tiles
    ld	de, _VRAM + $1a0
    ld	bc, Tiles.end - Tiles
CpTiles:
    ld	a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr 	nz, CpTiles
    

    ld	a, IEF_VBLANK 
    ld	[rIE], a

    ld	a, LCDCF_ON | LCDCF_BG8000 | LCDCF_BG9800 | LCDCF_OBJ8 | LCDCF_OBJON | LCDCF_WINOFF | LCDCF_BGON
                    ; lcd setup: tiles at $8000, map at $9800, 8x8 sprites (disabled), no window, etc.
    ld	[rLCDC], a			; enable lcd	

    DEF SIM_STEP EQU 1
    xor a
    ld [InputAsync], a
    ld [CurrentFrameAsync], a
    ld a, SIM_STEP
    ld [NextFrame], a

    ld a, $c3
    ldh [UpdateSub], a
    ld a, HIGH(Stage0)
    ldh [UpdateSub.addrHigh], a
    ld a, LOW(Stage0)
    ldh [UpdateSub.addrLow], a

    ei
    nop

GameLoop:
    ; Increase frame count
    ldh a, [CurrentFrameAsync]
    ldh [CurrentFrame], a
    ld hl, NextFrame
    cp [hl]
    jr c, Sleep

    ld a, SIM_STEP
    add a, [hl]
    ld [hl], a

    ; Read input
    ld a, P1F_GET_DPAD        
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]        
    and P1F_OUT
    swap a
    ld b, a
    ; Read and store button
    ld a, P1F_GET_BTN
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]  
    and P1F_OUT
    or b    ; add dpad
    ; Store into variable
    ldh [Joypad], a
    jp UpdateSub
    
    ; Yield CPU until next frame
Sleep::
    halt					
    nop	; halt bug
    jr	GameLoop


SECTION "ShadowOam", WRAM0[$C000]
ShadowOam::
    DS	160
.end

SECTION "Stack", WRAM0
Stack:
    DS 32
.end

SECTION "DmaSub", HRAM[$FF80]
DmaSub:
    DS DmaSubCode.end - DmaSubCode

SECTION "UpdateSub", HRAM
UpdateSub::
    DS 1    ;   jp hi lo
.addrLow::
    DS 1
.addrHigh::
    DS 1


SECTION "HRAM Variables", HRAM	
InputAsync:
    DS 1
CurrentFrameAsync:
    DS 1
CurrentFrame::
    DS 1    
NextFrame:
    DS 1
Joypad::
    DS 1