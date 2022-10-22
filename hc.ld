ENTRY(_start)

start_addr = 0x80000000;

PHDRS
{
	init	PT_LOAD FLAGS(5);
	text	PT_LOAD FLAGS(5);
}

SECTIONS
{
	.init start_addr : AT(start_addr)
	{ *(.init) } : init

	.text :
	{ *(.text) } : text
}
