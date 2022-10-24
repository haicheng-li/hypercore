#include "uart.h"

void kernel()
{
	char *msg = "hello kernel\n";

	printk(msg);
}
