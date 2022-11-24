	.text

	.global _start
_start:
	csrr a0, mhartid
	jal init_stack
	bnez a0, secondary
#	call init_vector
	#call test_swi
	call init_trap
	call switch_ctx
	la ra, _start
	ret	

secondary:
	call init_trap
	call switch_mode

init_stack:
	li sp, 0x80300000
	li t0, 0x10000
	mul t0, a0, t0
	sub sp, sp, t0
	#csrw sscrach, sp
	ret
	
message:
	.string "hello world\n"
