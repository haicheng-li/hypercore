ENTRY(_start)

start_addr = 0x80000000;
uapp_addr = 0x80080000;
kern_addr = 0x80180000;

PHDRS
{
	text	PT_LOAD FLAGS(5);
	text_app	PT_LOAD FLAGS(5);
	text_rest	PT_LOAD FLAGS(5);
}

SECTIONS
{
	. = start_addr;

	.text :
	{ start.o (.text) } : text

	. = uapp_addr;
	.text_app :
	{
		user.o (.text .text.*)
		user.o (.rodata .rodata.*)
		user.o (.data .data.*)
		user.o (.bss .bss.*)
		guest.o (.text .text.*)
		guest.o (.rodata .rodata.*)
		guest.o (.data .data.*)
		guest.o (.bss .bss.*)
		app.o
	} : text_app

	. = kern_addr;
	.text_rest :
	{ *(.text) } : text_rest
}
