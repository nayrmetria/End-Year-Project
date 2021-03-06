;============================================
; index.asm
;============================================

!cpu 6502
!to "build/game.prg",cbm ; specify output file

;============================================
; resourcefiles
;============================================
	
!source "code/config_resources.asm"

;============================================
; BASIC Loader
;============================================

* = $0801 								; BASIC start address at (#2049)
!byte $0d,$08,$dc,$07,$9e,$20,$34,$39   ; BASIC loader to start at $c000...
!byte $31,$35,$32,$00,$00,$00           ; puts BASIC line 2012 SYS 49152



;============================================
; 6502 start location
;============================================

* = $c000



;============================================
; sprite and resource loading
;============================================

!source "code/config_symbols.asm"
!source "code/config_sprites.asm"


;============================================
; Main routine
;============================================

!source "code/main.asm"

;============================================
; once-called subroutines
;============================================

!source "code/sub_clear_screen.asm"
!source "code/sub_write_text.asm"

;============================================
; IRQ called subroutines
;============================================

!source "code/sub_play_music.asm"
!source "code/sub_control_char.asm"
!source "code/sub_room_check.asm"

;============================================
; Misc Data such as text
;============================================

!source "code/data_title_text.asm"


;============================================
; END
;============================================
