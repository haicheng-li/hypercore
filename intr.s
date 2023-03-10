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
	li t0, 0xf500
	#li t0, 0x103
	csrw medeleg, t0

	ld ra, 0(sp)
	addi sp, sp, 8
	ret


	.globl vkernel
vkernel:
	call setup_mmu
	li a0, 0
	csrw sie, a0
	li a0, 0x00
	csrw sstatus, a0
	la a0, vkernel_msg
	call printk

	#used to check hs or vs mode
	#csrr t1, 0x600

	#call smp_start_cpus


	csrr t1, stvec
	la t0, vstrap_handler
	csrw stvec, t0

	csrr t1, sstatus
	la a0, guest
	li t0, 0x40080000
	sub a0, a0, t0
	csrw sepc, a0
	li a0, 0
	sret

	.globl vkernel2
vkernel2:
	call setup_mmu
	li a0, 0
	csrw sie, a0
	li a0, 0x100
	csrw sstatus, a0
	la a0, vkernel2_msg
	call printk
	la a0, guest
	csrw sepc, a0
	li a0, 0
	sret

kernel_init:
	call setup_mmu
	li a0, 0
	csrw sie, a0
	li a0, 0xC0000
	csrw sstatus, a0
#	call init_vmm
	la a0, kernel_msg
	call printk
#	call switch_vcpu
#	call smp_start_cpus
#	la a0, user
	la a0, app
#	li t0, 0x40080000
	li t0, 0x40000000
	sub a0, a0, t0
	csrw sepc, a0
	li a0, 0
	sret

idle_init:
	call setup_mmu
#	li a0, 0x2
#	csrw sie, a0
redo_idle:
	call do_idle
	call init_vmm
	call switch_vcpu2
	j redo_idle


	.balign 4
mtrap_handler:
	csrr a0, mcause
	li a1, 0x8000000000000000
	and a1, a0, a1
	andi a0, a0, 0xff
	bnez a1, mint_handler
	#li t0, 0x1900
	li t0, 0x800
	csrw mstatus, t0
	la a0, mtrap_msg
	call printk
	la t0, kernel
	csrw mepc, t0
	li a0, 0
	mret

	.balign 4
strap_handler:
	li a0, 0
	csrw sip, a0
	csrr t1, 0x600
	csrr a0, scause
	li a1, 0x8000000000000000
	and a1, a0, a1
	andi a0, a0, 0xff
	beqz a1, out
	call sint_handler
out:
	li a0, 0x000
	csrw sstatus, a0
	la a0, strap_msg
	call printk
	li a0, 0
	ecall

	.balign 4
vstrap_handler:
	li a0, 0
	csrw sip, a0

	#check if it's in VS mode
	#csrr t1, 0x600

	csrr a0, scause
	li a1, 0x8000000000000000
	and a1, a0, a1
	andi a0, a0, 0xff
	beqz a1, vout
	call sint_handler
vout:
	li a0, 0x000
	csrw sstatus, a0
	la a0, vstrap_msg
	call printk
	li a0, 0
	ecall


	.balign 4
trap_msg:
	.string "init_trap\n"

kernel_msg:
	.string "i'm kernel\n"

vkernel_msg:
	.string "i'm vkernel\n"

vkernel2_msg:
	.string "i'm vkernel2\n"

idle_msg:
	.string "i'm idle\n"

switch_msg:
	.string "switch context\n"

mtrap_msg:
	.string "mtrap handler\n"

strap_msg:
	.string "strap handler\n"

vstrap_msg:
	.string "vstrap handler\n"


	.globl switch_ctx
	.balign 4
switch_ctx:
	li t0, 0x0f
	csrw pmpcfg0, t0
	li t0, 0xffffffff
	csrw pmpaddr0, t0
	la a0, switch_msg
	call printk

	li t0, 0x1800
	csrc mstatus, t0
	li t0, 0x800
	csrs mstatus, t0
	la t0, kernel_init
	csrw mepc, t0
	mret

	.globl boot_idle
	.balign 4
boot_idle:
	li t0, 0x0f
	csrw pmpcfg0, t0
	li t0, 0xffffffff
	csrw pmpaddr0, t0
	la a0, idle_msg
	call printk
	li a0, 0x0a
	csrw mie, a0
	li t0, 0x8aa
	csrw mstatus, t0
	la t0, idle_init
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
