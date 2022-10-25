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
