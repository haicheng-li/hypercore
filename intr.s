	.text

	.globl init_vector
init_vector:
	la a0, vect_table
	addi a0, a0, 1
	csrw mtvec, a0
	li a0, 0xaa
	csrw mie, a0
	csrw mstatus, a0
	ret

	.globl init_trap
init_trap:
	addi sp, sp, -8
	sd ra, 0(sp)
	la a0, trap_msg
	call printk

	li t0, 0x222
	csrs mideleg, t0
	li t0, 0
	csrw mie, t0

	la t0, mtrap_handler
	csrw mtvec, t0
	la t0, strap_handler
	csrw stvec, t0

	li t0, 0x1800
	csrc mstatus, t0
	li t0, 0x1800
	#csrs mstatus, t0
	csrw mstatus, t0
	li t0, 0x100
	#li t0, 0x103
	csrw medeleg, t0

	ld ra, 0(sp)
	addi sp, sp, 8
	ret

kernel_init:
	#call setup_mmu

kernel:
	li a0, 0
	csrw sie, a0
	li a0, 0x0
	csrw sstatus, a0
	la a0, kernel_msg
	call printk
	la a0, user3
	csrw sepc, a0
	li a0, 0
	sret

user3:
	la a0, user3_msg
	call printk
	li a0, 0
	ecall


	.balign 4
mtrap_handler:
	#li t0, 0x1900
	li t0, 0x900
	csrw mstatus, t0
	la a0, mtrap_msg
	call printk
	la t0, kernel
	csrw mepc, t0
	li a0, 0
	mret

	.balign 4
strap_handler:
	li a0, 0x000
	csrw sstatus, a0
	la a0, strap_msg
	call printk
	li a0, 0
	ecall

trap_msg:
	.string "init_trap\n"

user3_msg:
	.string "i'm app\n"

kernel_msg:
	.string "i'm kernel\n"

switch_msg:
	.string "switch context\n"

mtrap_msg:
	.string "mtrap handler\n"

strap_msg:
	.string "strap handler\n"


	.globl switch_ctx
	.balign 4
switch_ctx:
	li t0, 0x0f
	csrw pmpcfg0, t0
	li t0, 0xffffffff
	csrw pmpaddr0, t0
	la a0, switch_msg
	call printk

	#li t0, 0x1800
	li t0, 0x800
	csrw mstatus, t0
	la t0, kernel_init
	csrw mepc, t0
	mret


	.balign 256
vect_table:
vect_rsv0:
	j expt_handler
vect_sswi:
	j sswi_handler
vect_rsv2:
	j expt_handler
vect_mswi:
	j mswi_handler
vect_rsv4:
	j expt_handler
vect_stimer:
	j stimer_handler
vect_rsv6:
	j expt_handler
vect_mtimer:
	j mtimer_handler
vect_rsv8:
	j expt_handler
vect_sexti:
	j sexti_handler
vect_rsv10:
	j expt_handler
vect_mexti:
	j mexti_handler


	.balign 256
vect_mtrap:
	j mtrap_handler

	.balign 256
vect_strap:
	j strap_handler
