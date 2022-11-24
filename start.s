	.text

	.global _start
_start:
	jal init_stack
#	call init_vector
	#call test_swi
	call init_trap
	#call switch_mode
	call switch_ctx
	la ra, _start
	ret	

init_stack:
	li sp, 0x80300000
	#csrw sscrach, sp
	ret
	
message:
	.string "hello world\n"
