;============================================
; config_resources.asm
;============================================

address_sprites = $2000
address_sid = $0812

* = address_sprites
!bin "resources/char.spd",1024,3

* = address_sid
!bin "resources/Moonlight_Sonata.sid",, $7c+2