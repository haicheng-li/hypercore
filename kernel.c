#include "uart.h"

void user()
{
	char *msg = "hello world\n";

	printk(msg);
	asm volatile("ecall"::);
}

void kernel2()
{
	char *msg = "hello kernel\n";

	printk(msg);
	asm volatile(
		"li t0, 0x100\n\t" \
		"csrw sstatus, t0\n\t" \
		"csrw sepc, %0\n\t" \
		"sret":: "r"(user)
	);
}

void switch_mode()
{
	printk("enter m_mode\n");
	asm volatile (
		"csrw mepc, %0\n\t" \
		"mret" :: "r"(kernel2)
	);
}
