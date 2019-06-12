;============================================
; Loads title text
;============================================

write_text	lda $d018
			ora #$0e	; sets char location to $3800 instead of ROM
			sta $d018	; bits 1-3 of $d018 set the char location apparently 

			lda $d016	; turns off multicolor for characters
			and #$ef	; clears bit 4 of $d016
			sta $d016

loop_title_text	lda #$01	
				sta $d9f3,x 
				lda title,x ; read characters from data file
				sta $05f3,x	; place near center of screen ram

				inx
				cpx #$09	; finished when all 10 columns are processed
				bne loop_title_text
				rts


