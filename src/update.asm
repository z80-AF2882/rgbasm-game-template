INCLUDE "hardware.inc"
INCLUDE "debug.inc"

SLEEP: MACRO
    rst 38
    ENDM

SLEEP_NZ: MACRO
    call nz,$0038
    ENDM    

; Set stage 
STAGE: MACRO
    ld a, HIGH(\1)
    ldh [UpdateSub.addrHigh], a
    ld a, LOW(\1)
    ldh [UpdateSub.addrLow], a
    ENDM

SECTION "Update", ROM0
; Scroll logo UP
Stage0::
    ldh a, [CurrentFrame]
    bit 0, a
    jp nz, Sleep
    ld hl, rSCY
    inc [hl]
    ld a, 30
    cp [hl]
    jp nz, Sleep
    STAGE(DrawBuilding1)
    jp Sleep
.end

; Draw building
DrawBuilding1:    
    ld de, $10
    ld hl, $9942
    ld a, $29
    ld [hli], a
    ld a, $28
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $2b
    ld [hli], a        
    ;
    add hl, de
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a
    add hl, de
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $27    
    ld [hli], a
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $27    
    ld [hli], a
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $27    
    ld [hli], a
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $27    
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a
    ;
    add hl, de
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld a, $2e
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2e
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2e
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2e
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a   
    ;
    add hl, de
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a

    xor a
    ld [$9910], a

    STAGE(DrawBuilding2)
    jp Sleep
.end

DrawBuilding2:
    ldh a, [CurrentFrame]
    cp 80
    jp nz, Sleep
    STAGE(DrawBuilding3)
    jp Sleep

; Draw building
DrawBuilding3:
    ld hl, $99c2
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a
    ;
    ld de, $10
    add hl, de
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a
    ;
    add hl, de
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld a, $2e
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2e
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2e
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2e
    ld [hli], a
    ld a, $27  
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a
    ;
    add hl, de
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a   

    STAGE(DrawBuilding4)
    jp Sleep
.end    

DrawBuilding4:
    ldh a, [CurrentFrame]
    cp 100
    jp nz, Sleep
    STAGE(DrawBuilding5)
    jp Sleep    


; Draw building
DrawBuilding5:
    ld hl, $9a42
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $2f
    ld [hli], a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a
    ;
    add hl, de
    ld a, $2a
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $30
    ld [hli], a
    ld a, $31
    ld [hli], a
    ld a, $27
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $2c
    ld [hli], a

    STAGE(DrawBuilding6)
    jp Sleep
.end

DrawBuilding6:
    ldh a, [CurrentFrame]
    cp 130
    jp nz, Sleep
    STAGE(DrawBuilding7)
    jp Sleep    
.end    

DrawBuilding7:
    ld a, $24
    ld hl, $9a80
    ld [hli], a
    ld [hli], a
    ld a, $26
    ld [hli], a
    ld a, $25
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld [hli], a
    ld a, $26
    ld [hli], a
    ld a, $25
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld [hli], a
    ld a, $26
    ld [hli], a
    ld a, $25
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld [hli], a
    ld a, $26
    ld [hli], a
    ld a, $25
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld [hli], a
    ld a, $26
    ld [hli], a
    ld a, $25
    ld [hli], a   
    STAGE(Ufo1)
    jp Sleep
.end    

Drop1:
    ld a, 44
    ld [ShadowOam], a
    ld a, 136
    ld [ShadowOam + 1], a
    ld a, $19
    ld [ShadowOam + 2], a
    xor a
    ld [ShadowOam + 3], a
    ld [$9910], a   ; remove "R" tile from bg
    STAGE(Drop2)
.end

Drop2:
    
    jp Sleep
.end

Ufo1:
    ld a, 20
    ld [ShadowOam], a
    ld a, -8
    ld [ShadowOam + 1], a
    ld a, $1b
    ld [ShadowOam + 2], a
    xor a
    ld [ShadowOam + 3], a

    ld a, 20
    ld [ShadowOam + 4], a
    ld a, -16
    ld [ShadowOam + 5], a
    ld a, $23
    ld [ShadowOam + 6], a
    xor a
    ld [ShadowOam + 7], a

    ld a, 20
    ld [ShadowOam + 8], a
    ld a, 0
    ld [ShadowOam + 9], a
    ld a, $23
    ld [ShadowOam + 10], a
    ld a, OAMF_XFLIP
    ld [ShadowOam + 11], a

    STAGE(Ufo2)
    jp Sleep 

Ufo2:
    ld hl, ShadowOam + 1
    inc [hl]
    ld hl, ShadowOam + 5
    inc [hl]
    ld hl, ShadowOam + 9
    inc [hl]
    ld a, [ShadowOam + 1]
    cp 60
    jp nz, Ufo3.animate
    STAGE(Ufo3)
    jp Sleep
.end

Ufo3:    
.checkUp
    bit 6, a
    jr nz, .checkDown    
    ld hl, ShadowOam + 0
    dec [hl]
    ld hl, ShadowOam + 4
    dec [hl]
    ld hl, ShadowOam + 8
    dec [hl]
.checkDown    
    bit 7, a
    jr nz, .checkLeft
    ld hl, ShadowOam + 0
    inc [hl]
    ld hl, ShadowOam + 4
    inc [hl]
    ld hl, ShadowOam + 8
    inc [hl]
.checkLeft
    bit 4, a
    jr nz, .checkRight
    ld hl, ShadowOam + 1
    inc [hl]    
    ld hl, ShadowOam + 5
    inc [hl]    
    ld hl, ShadowOam + 9
    inc [hl]    
.checkRight
    bit 5, a
    jr nz, .animate
    ld hl, ShadowOam + 1
    dec [hl]    
    ld hl, ShadowOam + 5
    dec [hl]    
    ld hl, ShadowOam + 9
    dec [hl]    
.animate
    ld a, [CurrentFrame]
    and $07
    jp nz, Sleep
    
    ld a, [ShadowOam + 2]
    inc a
    cp a, $1a + 9
    jr nz, .updateAnimation
    ld a, $1a
.updateAnimation
    ld [ShadowOam + 2], a
    jp Sleep
.end
