; Since I've learned to use equ as I would define in C to set constants...
sys_exit  equ 1 ; System call codes
sys_read  equ 3
sys_write equ 4
stdin	  equ 0 ; FD codes
stdout	  equ 1

segment .data
	
	msg1 db "Enter a digit: "
	len1 equ $ - msg1
	
	msg2 db "Enter another digit: "
	len2 equ $ - msg2

	msg3 db "The sum is: "
	len3 equ $ - msg3

segment .bss

	num1 resb 2	; Reserve two bytes for variable num1
	num2 resb 2
	res  resb 1 ; Reserve one byte for variable res

section .text
	global _start ; Tell linker entrypoint

_start:
	; Display prompt
	mov eax, sys_write
	mov ebx, stdout
	mov ecx, msg1
	mov edx, len1
	int 80h	; Call kernel via interrupt

	; Grab first number
	mov eax, sys_read
	mov ebx, stdin ; Store fd in ebx
	mov ecx, num1  ; First param, where we're reading to
	mov edx, 2     ; Second param, how much we're reading
	int 80h		   ; Call kernel via interrupt

	; Display second prompt
	mov eax, sys_write
	mov ebx, stdout
	mov ecx, msg2  ; First param, where we're reading from
	mov edx, len2  ; Second param, how much we're writing (len of msg2 in bytes)
    	int 80h		   ; Call kernel via interrupt
	
	; Grab second number
	mov eax, sys_read
	mov ebx, stdin
	mov ecx, num2
  	mov edx, 2
	int 80h

	; Print text before displaying result
	mov eax, sys_write
	mov ebx, stdout
	mov ecx, msg3
	mov edx, len3
	int 80h

	; Convert from ascii to actual numbers
	mov eax, [num1] ; Move first number to eax
	sub eax, '0'	; Subtract ascii 0 to conver to decimal number
	
	mov ebx, [num2]
	sub ebx, '0'

	; Add them together
    	add eax, ebx 	; Remember our numbers are stores in the eax and ebx registers, result is stored in eax
	
	; Convert back to ascii
	add eax, '0'

	; Store result in our reserved space
	mov [res], eax
	
	; Print sum
	mov eax, sys_write
	mov ebx, stdout
	mov ecx, res
	mov edx, 1
	int 80h
	
exit:
	
	mov eax, sys_exit
	xor ebx, ebx ; Comparing operand to itself yields 0, the exit code we'll return
	int 80h
