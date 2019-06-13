;============================================
; character control
;============================================

control_character	lda #%00000001			; check against UP movement
					bit $dc00				; bitwise AND with 56320 (joystick register)
					bne down				; skips over the sprite movement if the AND returns a 
					dec $d001				; move the sprite up
					jmp up_ani				 									

down				lda #%00000010			; check against DOWN movement
					bit $dc00				; bitwise AND with 56320 
					bne left				; skips over the sprite movement
					inc $d001				; move sprite down

left				lda #%00000100			; check against LEFT movement
					bit $dc00				; bitwise AND with 56320
					bne right				; skips over sprite movement
					dec $d000				; moves sprite left

					lda #%11111111
					bit $d000
					beq in_between_left


right 				lda #%00001000			; check against RIGHT movement
					bit $dc00				; bitwise AND with 56320
					bne exit				; skips over sprite movement
					inc $d000				; moves sprite right

					lda #%11111111			; check for full bitwise
					cmp $d000
					beq in_between_right
					jmp exit

in_between_right	lda #$01				; check for 9th bit
					cmp $d010				; does actuall sub comp
					beq loop_right			; goes to loop around
					jmp x_high

in_between_left		lda #$01				; check for 9th bit
					cmp $d010				; checks if there is a 9th bit
					beq x_high
					jmp loop_left

loop_left			lda #$ff
					sta $d000
					lda room_check_reg
					adc #%00010000			; forces player to move room to x one
					sbc #%10000000
					sta room_check_reg
					jmp x_high				

loop_right			lda #$00
					sta $d000
					lda room_check_reg
					adc #%00010000
					sbc #%10000000
					sta room_check_reg

x_high				lda $d010 				; loads the 9th bit address
					eor #$01				; forces it to change
					sta $d010
					jmp exit

up_ani				lda delay_animation_pointer
					eor #$01
					sta delay_animation_pointer
					beq exit
					lda sprite_char_current_frame
					bne increase_sprite

reset_frames 		lda #sprite_char_frames
					sta sprite_char_current_frame
					lda #sprite_char_pointer
					sta screen_ram + $3f8


increase_sprite		inc screen_ram + $3f8
					dec sprite_char_current_frame
					jmp down



exit				rts						; exits back to interrupt sequence

