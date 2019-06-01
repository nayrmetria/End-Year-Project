;============================================
; config_sprites.asm
;============================================

;============================================
; variables 
;============================================

sprite_char_current_frame = $fb
sprite_char_frames = 10
sprite_char_pointer = address_sprites / $40
sprite_background_color = $00
sprite_multicolor_1 = $0b
sprite_multicolor_2 = $01
sprite_ship_color = $02


;============================================
; initialize memory
;============================================
lda #sprite_char_frames
sta sprite_char_current_frame

lda #sprite_char_pointer
sta screen_ram + $3f8

;============================================
; initialize VIC-II registers
;============================================

lda #$01 ; enables Sprite#0
sta $d015
lda #$01 ; sets multicolor for Sprite#0
sta $d01c
lda #$00 ; Sprite#0 has priority over background
sta $d01b

; set colors for Sprite#0

lda #sprite_background_color
sta $d021
lda #sprite_multicolor_1
sta $d025
lda #sprite_multicolor_2
sta $d026
lda #sprite_ship_color
sta $d027

lda #$00 ; set X-Coord Bit low (we don't need to go off screen)
sta $d010

lda #$b7  ; set Sprite#0 positions with coords to center
sta $d000 ; X-Coord
lda #$7d 
sta $d001 ; Y-Coord



