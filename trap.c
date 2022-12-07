#include "uart.h"
#include "kernel.h"

static int cpu_id()
{
	int cpu;

	asm volatile (
		"csrr a0, mhartid \n\t" \
		"mv %0, a0 \n\t" \
		:"=r"(cpu):
	);

	return cpu;
}

void expt_handler()
{
	printk("resv expt_handler\n");
}

void sswi_handler()
{
	int cpu = 0;
	char *s = "sswi_handler: d\n";

	s[14] = cpu + '0';
	printk(s);

//	asm volatile ("csrwi sip, 0\n\t"::);
}

void mswi_handler()
{
	int cpu = cpu_id();
	char *s = "mswi_handler: d\n";

	s[14] = cpu + '0';
	printk(s);
	cpu *= 4;
	cpu += 0x02000000;

	asm volatile(
		"li t0, 0 \n\t" \
		"sw t0, 0(%0) \n\t" \
		"li t0, 0x2 \n\t" \
		"csrw mip, t0\n\t"
		:: "r"(cpu)
	);
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

typedef void (* irq_handler_t)(void);
static irq_handler_t mirq_handler[] = {
	expt_handler,
	expt_handler,
	expt_handler,
	mswi_handler,
	expt_handler,
	expt_handler,
	expt_handler,
	mtimer_handler,
	expt_handler,
	expt_handler,
	expt_handler,
	mexti_handler,
	expt_handler
};

void mint_handler(int irq)
{
	printk("mint_handler\n");
	if (irq < 12)
		mirq_handler[irq]();
	else
		mirq_handler[12]();

	asm volatile (
		"csrw mepc, %0\n\t" \
		"mret" :: "r"(kernel)
	);
}

static irq_handler_t sirq_handler[] = {
	expt_handler,
	sswi_handler,
	expt_handler,
	stimer_handler,
	expt_handler,
	sexti_handler,
	expt_handler
};

void sint_handler(int irq)
{
	printk("sint handler\n");
	if (irq < 6)
		sirq_handler[irq]();
	else
		sirq_handler[6]();
}
