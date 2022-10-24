#define UART_BASE (volatile unsigned int *)0x10000000

static void write32(volatile unsigned int *addr, char c)
{
	*addr = c;
}

static void write8(volatile unsigned char *addr, char c)
{
	*addr = c;
}

static void init_uart()
{
	write32(UART_BASE + 0xe, 0x10);
}

static void put_char(char c)
{
	unsigned char t = 0;
	write8((volatile unsigned char *)UART_BASE, c);
	while (!t)
		t = *((volatile unsigned char *)UART_BASE + 0x5) & 0x20;
}

void printk(char *buf)
{
	int i = 0;
	if (buf == 0)
		return;

	while (buf[i] != '\0') {
		if (buf[i] == '\n')
			put_char('\r');
		put_char(buf[i++]);
	}
}
