.bss
	base:		.quad
	exponent:	.quad

.text
calin_name_netid: .asciz "Calin Radoi (cradoi)\n"
rares_name_netid: .asciz "Rares Diaconescu (rdiaconescu)\n"
assignment_name: .asciz "Powers\n"
input_format: .asciz "%lq"

print:
	movq	$1, %rax
	movq	$1, %rdi
	movq	%rcx, %rsi
	movq 	%r8, %rdx
	syscall
	ret
read:
	movq	$0, %rax
	movq 	$0, %rdi
	movq	%rcx, %rsi
	movq	$8, %rdx
	syscall
	ret
.global main
main:
	push    %rbp
    	mov     %rsp, %rbp


    	mov     $calin_name_netid, %rcx
    	mov     $21, %r8
    	call    print
    	mov     $rares_name_netid, %rdi
   	mov     $0, %rax
    	call    printf
   	mov     $assignment_name, %rdi
	mov     $0, %rax
	call	printf

	mov	$base, %rcx
	call 	read

	mov 	$exponent, %rcx
	call	read

	mov 	$exponent, %rax
	cmp	$0, %rax
	je	print_one
	jmp 	end

print_one:
	mov 	$1, %rdi
	mov	$0, %rax
	call 	printf
end:
    	call exit
        