
section .text
	global _start

_start:
	mov edx, len ;store msg len in edx
	mov ecx, msg ;store msg to write in ecx
	mov ebx, 1	 ;store FD in ebx
    mov eax, 4	 ;store system call number in EAX
	int	0x80	 ;gen interrupt to call kernel

    ;we're going to print another msg
	mov edx,12
	mov ecx,s2
	mov ebx,1
	mov eax,4
    int 0x80

    mov eax,1 ;change system call number stored in eax with 1
    int 0x80 ;call kernel

section .data
msg db 'First message. 12 stars next', 0xa ;msg
len equ $ - msg ;len of msg
s2 times 12 db '*' ; s2 = 12 * '*'
	
