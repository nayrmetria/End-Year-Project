;============================================
; config_resources.asm
;============================================

address_sprites = $2000
address_sid = $0812
address_chars = $3800

* = address_sprites
!bin "resources/char.spd",640,3 	; 64x10 space for the character sprites 

* = address_sid
!bin "resources/Moonlight_Sonata.sid",, $7c+2

* = address_chars
!bin "resources/bruh.ctm",496,24	; skips 24 bytes which is part of CharPad format
									; loads 62x8 space for the characters (8 bytes)
