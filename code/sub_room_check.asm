;============================================
;	Room Check
;============================================

check_room	lda room_check_reg	; loads in the room check register
			
			and #%11111111		; check if rooms are 0
			beq load_room_0_0	; goes to load Room 0,0 (start room)

			rts

load_room_0_0	lda #$01
				sta $0400,x
				lda start_room,x
				sta $0400,x

				inx
				cpx #$28
				bne load_room_0_0
				rts




