#include "uart.h"

void guest()
{
	printk("this is guest\n");
	/* check if it's in U mode */
	//asm volatile ("csrr t0, sstatus"::);

	asm volatile ("ecall"::);
}

