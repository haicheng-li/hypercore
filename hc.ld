ENTRY(_start)

start_addr = 0x80000000;

PHDRS
{
	text	PT_LOAD FLAGS(5);
}

SECTIONS
{
	. = start_addr;

	.text :
	{ start.o (.text) } : text

	.text_rest :
	{ *(.text) } : text
}
