#include "uart.h"

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
