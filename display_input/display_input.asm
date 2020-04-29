section .data ;Data section
	userMsg db 'Enter a number: ' ;Ask user for input
	lenUserMsg equ $-userMsg	  ;Store len of msg
	dispMsg db 'You entered: '
	lenDispMsg equ $-dispMsg	  ;Store len of display msg

section .bss ;Variables (uninitialized data)
	num resb 5	;5 bytes, 4 for actual number 1 for sign (normal int)

section .text
	global _start ;Run start section on init

;Notice below the registers are used in order EAX, EBX, ECX, EDS
;Always do this, it is more efficient (except when its not)
_start:
	;Prompt user for input
	mov eax, 4
	mov ebx, 1
	mov ecx, userMsg
	mov edx, lenUserMsg
	int 0x80

	;Read/store user input
	mov eax, 3   ;Store system call number (sys_read)
	mov ebx, 2   ;Store file descriptor (STDIN)
	mov ecx, num ;Store the starting address of our num var in ecx
	mov edx, 5   ;Open up 5 bytes for input (num, 4 for int 1 for sign)
	int 0x80     ;Call kernel via interrupt, we could have also entered the addr as 80h (80 hex)

	;Output prompt for input and store number entered
	mov eax, 4
	mov ebx, 1    		;Store FD (STDOUT)
	mov ecx, dispMsg 	;Store addr of dispMsg in ecx
	mov edx, lenDispMsg	;Store addr of lenDispMsg
	int 0x80

	;Output result
	mov eax, 4
	mov ebx, 1
	mov ecx, num	;Store addr of num
	mov edx, 5	;Plus the next 5 bytes
	int 0x80

	;Exit
	mov eax, 1 ;System call number (sys_exit)
	mov ebx, 0 ;Return code on exit (return 0; in c)
	int 0x80
