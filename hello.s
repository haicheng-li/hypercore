.global _start
.text
_start:
	li a3, 0
	mv ra, a0
	mv a0, a3
	add a1, a0, 100
	lw a2, message
	mv a0, a2
	mv a1, a2
	lui a3, %hi(_start)
	addi a3, a3, %lo(_start)
	mv ra, a3
	ret

message:
	.string "hello world"
