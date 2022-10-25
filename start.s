.global _start
.section ".init"
_start:
	li a3, 0
	mv ra, a0
	mv a0, a3
	add a1, a0, 100
	lw a2, message
	mv a0, a2
	mv a1, a2
	jal init_stack
	call init_vector
	call kernel
	addi a3, a3, %lo(init_stack)
	lui a3, %hi(init_stack)
	addi a3, a3, %lo(init_stack)
	mv ra, a3
	la ra, _start
	ret	

init_stack:
	li sp, 0x80020000
	#csrw sscrach, sp
	ret
	
message:
	.string "hello world"
