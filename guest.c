#include "uart.h"

void guest()
{
	printk("this is guest\n");
	asm volatile ("ecall"::);
}

