#include "uart.h"

static void test_swi()
{
	asm volatile (
		"li a0, 0x1 \n\t" \
		"li a1, 0x02000000 \n\t" \
		"sw a0, 0(a1) \n\t"
		::
	);
}

void kernel()
{
	char *msg = "hello kernel\n";

	printk(msg);
	printk("trigger swi\n");
	test_swi();
}
