void printk(char *fmt, char *s)
{
	return;
}

void kernel()
{
	char *msg = "hello kernel";

	printk("%s\n", msg);
}
