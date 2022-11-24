	.text

	.global _start
_start:
	#j start
	li a3, 0
	mv ra, a0
	mv a0, a3
	add a1, a0, 100
	lw a2, message
	mv a0, a2
	mv a1, a2
	jal init_stack
#	call init_vector
	#call test_swi
	call init_trap
	#call switch_mode
	#call setup_mmu
	call switch_ctx
	mv ra, a3
	la ra, _start
	ret	

init_stack:
	li sp, 0x80300000
	#csrw sscrach, sp
	ret
	
message:
	.string "hello world\n"
