/* The bootloader will look at this image and start execution at the symbol
   designated as the entry point. */
ENTRY(_start)

SECTIONS
{
	/* It used to be universally recommended to use 1M as a start offset,
	   as it was effectively guaranteed to be available under BIOS systems.
	   However, UEFI has made things more complicated, and experimental data
	   strongly suggests that 2M is a safer place to load. In 2016, a new
	   feature was introduced to the multiboot2 spec to inform bootloaders
	   that a kernel can be loaded anywhere within a range of addresses and
	   will be able to relocate itself to run from such a loader-selected
	   address, in order to give the loader freedom in selecting a span of
	   memory which is verified to be available by the firmware, in order to
	   work around this issue. This does not use that feature, so 2M was
	   chosen as a safer option than the traditional 1M. */
    . = 2M;

    .text BLOCK(4k) : ALIGN(4k)
    {
        *(.multiboot)
        *(.text)
    }

    .rodata BLOCK(4k) : ALIGN(4k)
    {
        *(.rodata)
    }

    .data BLOCK(4k) : ALIGN(4k)
    {
        *(.data)
    }

    .bss BLOCK(4k) : ALIGN(4k)
    {
        *(COMMON)
        *(.bss)
    }

    
}