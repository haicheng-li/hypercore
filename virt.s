	.text

	.globl init_vmode
init_vmode:
	li t0, 0x8000000000
	csrs mstatus, t0
	ret

	.globl init_vmm
init_vmm:
	csrr t1, hstatus
	li t0, 0x180
	li t0, 0x200000180
	csrw hstatus, t0
	csrr t1, hstatus
	csrc hstatus, t1
	csrr t1, hstatus
	li t0, 0x200000080
	csrs hstatus, t0
	#csrw hstatus, t0
	#csrw 0x600, t0
	csrr t1, hstatus
	ret


	.globl switch_vcpu
switch_vcpu:
	la t0, guest
	csrw sepc, t0
	sret
