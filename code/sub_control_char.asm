;============================================
; character control
;============================================

control_character	lda #%00000001			; check against UP movement
					bit $dc00				; bitwise AND with 56320 (joystick register)
					bne down				; skips over the sprite movement if the AND returns a 
					dec $d001				; move the sprite up

down				lda #%00000010			; check against DOWN movement
					bit $dc00				; bitwise AND with 56320 
					bne left				; skips over the sprite movement
					inc $d001				; move sprite down

left				lda #%00000100			; check against LEFT movement
					bit $dc00				; bitwise AND with 56320
					bne right				; skips over sprite movement
					dec $d000				; moves sprite left

right 				lda #%00001000			; check against RIGHT movement
					bit $dc00				; bitwise AND with 56320
					bne exit				; skips over sprite movement
					inc $d000				; moves sprite right

exit				rts						; exits back to interrupt sequence

