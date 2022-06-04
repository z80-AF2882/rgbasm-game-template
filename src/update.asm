INCLUDE "hardware.inc"
INCLUDE "debug.inc"

SECTION "Variables", HRAM
Stage:
    DS 1

SECTION "Init", ROM0
Init::
    xor a
    ldh [Stage], a
    jp Sleep
.end


SECTION "Update", ROM0
Update::
    ldh a, [Stage]
    cp 0
    jp z, Stage0
    cp 1
    jp z, Stage1
    cp 2
    jp z, Stage2
    DBGSTOP

Stage0:
    ld a, AUDENA_ON
    ldh [rNR52], a
    ld a, $11
    ldh [rNR51], a
    ld a, $77
    ldh [rNR50], a

    ld a, %1_0_000_011
    ldh [rNR14], a
    ld a, %00010101
    ldh [rNR13], a
    ld a, $f3
    ldh [rNR12], a    
    ld a, $10
    ldh [rNR11], a
    ld a, $00
    ldh [rNR10], a
    
    
    

.end    
    jp Sleep

Stage1:
    ldh a, [CurrentFrame]
    bit 0, a
    jr nz, .end
    ld hl, rSCY
    inc [hl]
    ld a, 30
    cp [hl]
    jr nz, .end
    ld a, 1
    ldh [Stage], a
    jp Sleep
.end
Stage2:
.checkUp
    bit 6, a
    jr nz, .checkDown    
    ld hl, ShadowOam
    dec [hl]
.checkDown    
    bit 7, a
    jr nz, .checkLeft
    ld hl, ShadowOam
    inc [hl]
.checkLeft
    bit 4, a
    jr nz, .checkRight
    ld hl, ShadowOam + 1
    inc [hl]    
.checkRight
    bit 5, a
    jr nz, .animate
    ld hl, ShadowOam + 1
    dec [hl]

.animate
    ld a, [CurrentFrame]
    and $07
    jr nz, .end
    
    ld a, [ShadowOam + 2]
    inc a
    cp a, $1a + 8
    jr nz, .updateAnimation
    ld a, $1a
.updateAnimation
    ld [ShadowOam + 2], a
    jp Sleep
.end    