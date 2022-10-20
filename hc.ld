ENTRY(_start)

start_addr = 0x80000000;

PHDRS
{
	text	PT_LOAD FLAGS(5);
}

SECTIONS
{
	.text start_addr : AT(start_addr)
	{ *(.text) } : text
}
