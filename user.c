#include "uart.h"

char stack[4096] = {0};

void user()
{
	while(1);
//	char *msg = "hello world\n";

	asm volatile("li t0, 0\n\t"::);
	asm volatile("li t1, 1\n\t"::);
	asm volatile("li t2, 2\n\t"::);
//	printk(msg);
	asm volatile("ecall"::);
}
