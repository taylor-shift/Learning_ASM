section .text		;note we can also use the word segment
    global _start	;tell it what section to start on exec

_start:		    	;entry point
	mov	edx,len	;msg len
	mov	ecx,msg ;msg to write
	mov	ebx,1	;FD (stdout, just like C)
	mov	eax,4	;system call number (sys_write)
	int	0x80	;call kernel

	mov	eax,1	;system call number (sys_exit)
	int	0x80	;call kernel

section .data
msg db 'Hello from assembly', 0xa	;string to print
len equ $ - msg	;len of string
;after we compile into object code with nasm -f elf64
;then link with ld objectfile executablename
