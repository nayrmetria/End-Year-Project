;============================================
;	Room Check
;============================================

check_room	lda room_check_reg	; loads in the room check register
			
			eor #%10000000		; this checks if the most sig bit is 1, which means that this room has been loaded already
			and #%10000000
			beq outta

			lda room_check_reg
			and #%11111111		; 0 		 000			0000
								; ^ load bit  ^ x bits		^ y bits
			ldx #$00
			beq load_room_0_0	; goes to load Room 0,0 (start room)

			lda room_check_reg
			cmp #%00010000
			ldx #$00
			beq load_room_1_0


outta		rts

load_room_1_0	lda $3e30,x		; where room 1 0 code is located (1000 bytes or 3e8 after $3a48)
				sta $0400,x
				lda $3f30,x
				sta $0500,x
				lda $4030,x
				sta $0600,x
				lda $4130,x
				sta $06e8,x

				lda #$01
				sta $d800,x
				sta $d900,x
				sta $da00,x
				sta $dae8,x

				inx
				bne load_room_1_0
				ldx #$00
				jmp space_black

load_room_0_0	lda $3a48,x		; where the room 0 0 code is located
				sta $0400,x 	; these lines write to the four increments of screen
				lda $3b48,x
				sta $0500,x
				lda $3c48,x 
                sta $0600,x
                lda $3d30,x 
               	sta $06e8,x 

               	lda #$01	; puts into the associated color ram white (#$01)...
                sta $d800,x ; and this will become color of the scroll text
                sta $d900,x
                sta $da00,x
                sta $dae8,x

   				

				inx
				bne load_room_0_0
				ldx #$00

space_black		lda $0400,x		
				cmp #%01011101	; checks if its a space (specifically PETSCII ], or $005d)
				beq d800_blk
ret_d800		inx
				bne space_black
				ldx #$00
sb_1			lda $0500,x
				cmp #%01011101
				beq d900_blk
ret_d900		inx
				bne sb_1
				ldx #$00
sb_2			lda $0600,x
				cmp #%01011101
				beq da00_blk
ret_da00		inx
				bne sb_2
				ldx #$00
sb_3			lda $06e8,x
				cmp #%01011101
				beq dae8_blk
ret_dae8		inx
				bne sb_3

				lda #%10000000
				sta room_check_reg
				rts


d800_blk		lda #$00		; loads black into acc
				sta $d800,x		; loads into corr. mem addr
				jmp ret_d800		
d900_blk		lda #$00
				sta $d900,x
				jmp ret_d900
da00_blk		lda #$00
				sta $da00,x
				jmp ret_da00
dae8_blk		lda #$00
				sta $dae8,x
				jmp ret_dae8




	
						


