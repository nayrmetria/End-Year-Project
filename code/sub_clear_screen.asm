;============================================
; Clears screen
;============================================

clear_screen	ldx #$00 	; start of loop
				stx $d021	; write black to screen color
                ldy #$02    ; write red
                ;ldy #$00
                sty $d020   ; write red to border color

clear_loop		lda #$20	; $20 is spacebar screencode for PETSCII
				sta $0400,x ; these lines write to the four corners
				sta $0500,x 
                sta $0600,x 
               	sta $06e8,x 
                lda #$00    ; puts into the associated color ram black (#$00)...
                sta $d800,x ; and this will become color of the scroll text
                sta $d900,x
                sta $da00,x
                sta $dae8,x
                inx         
                bne clear_loop   
                rts