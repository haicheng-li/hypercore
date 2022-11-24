	.text
	.globl setup_mmu

setup_mmu:
	lw a0, level0
	li a1, 0x80100000
	li t0, 0
	li t1, 1024
lvl0:
	sw a0, 0(a1)
	addi a1, a1, 4 
	addi t0, t0, 4
	addi a0, a0, 1024
	blt t0, t1, lvl0

	lw a0, level1
	li a1, 0x80101000
	li t0, 0
	li t1, 0xff000
lvl1:
	sw a0, 0(a1)
	addi a1, a1, 4
	addi t0, t0, 4
	addi a0, a0, 1024
	blt t0, t0, lvl1

mmu_jump:
	#li a0, 0x80100
	li a0, 0x800100
	slli a0, a0, 2
	li t0, 0x80000000
	add a0, a0, t0 
	csrw satp, a0
	ret

level0:	
	.word 0x801010ff
level1:
	.word 0x801000ff
