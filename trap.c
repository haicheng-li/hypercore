#include "uart.h"
#include "kernel.h"

void expt_handler()
{
	printk("expt_handler\n");
}

void sswi_handler()
{
	printk("sswi_handler\n");
}

void mswi_handler()
{
	printk("mswi_handler\n");
}

void stimer_handler()
{
	printk("stimer_handler\n");
}

void mtimer_handler()
{
	printk("mtimer_handler\n");
}

void sexti_handler()
{
	printk("sexti_handler\n");
}

void mexti_handler()
{
	printk("mexti_handler\n");
}

void test_swi()
{
	printk("trigger swi\n");
	asm volatile (
		"li a0, 0x1 \n\t" \
		"li a1, 0x02000000 \n\t" \
		"sw a0, 0(a1) \n\t"
		::
	);
}

/*
void mtrap_handler()
{
	printk("mtrap handler\n");
	asm volatile (
		"csrw mepc, %0\n\t" \
		"mret" :: "r"(kernel)
	);
}

void strap_handler()
{
	printk("strap handler\n");
	asm volatile (
		"la t0, user\n\t" \
		"csrw sepc, t0\n\t" \
		"sret"::);
	asm volatile ("ecall"::);
}
*/
