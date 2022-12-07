#include "uart.h"

void do_idle()
{
	printk("enter s_mode idle, wait for ipi\n");
	asm volatile ("wfi"::);
	printk("exit s_mode idle by ipi\n");
	while(1);
}

static void do_swi(int cpu)
{
	printk("trigger swi\n");
	cpu *= 4;
	cpu += 0x02000000;
	asm volatile (
		"li a0, 1\n\t" \
		"sw a0, 0(%0) \n\t"
		:: "r"(cpu)
	);
}

int g_cpus = 1;
void smp_start_cpus()
{
	for (int i = 1; i < g_cpus; i++) {
		do_swi(i);
	}

	while(1);
}
