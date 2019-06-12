;============================================
; main.asm
;============================================


main	sei			; set interrupt disable flag
		jsr clear_screen
		jsr write_text
		jsr $0856	; start playing SID music (Moonlight Sonata for now) init address at $0856

		ldy #$7f    ; $7f = %01111111
    	sty $dc0d   ; Turn off CIAs Timer interrupts
		sty $dd0d   ; Turn off CIAs Timer interrupts
		lda $dc0d   ; cancel all CIA-IRQs in queue/unprocessed
		lda $dd0d   ; cancel all CIA-IRQs in queue/unprocessed

		lda #$01 	; set Interrupt Request Mask
		sta $d01a	; IRQ via rasterbeam hijacking

		lda $d011	; bit 0 of $d011 is 9th bit for $d012
		and #$7f
		sta $d011	; makes sure that it's also set to 0

		lda #<irq 	; point to custom IRQ vector
		ldx #>irq  	; same thing
		sta $314	; store IRQ vector in $314/$315
		stx $315

		lda #$00	; trigger first interrupt at row 0 
		sta $d012	; $d012 contains the current raster line 




		cli
		jmp *		; infinite loop


;============================================
; actually defining the custom interrupt routine
;============================================

irq		dec $d019		; is the equivalent of "lda $d019 / sta $d019"  
		
		jsr play_music	; music playing subroutine
		jsr control_character
		jsr check_room
		

		jmp $ea81		; return to kernel's interrupt routine
	
