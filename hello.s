.global _start
.text
_start:
	li a3, 0x80000000
	mv ra, a0
	mv a0, a3
	add a1, a0, 100
	lw a2, message
	mv a0, a2
	mv a1, a2
	mv ra, a3
	ret

message:
	.string "hello world"
