
.global main
main:
	push	%rbp
	mov	%rsp, %rbp

	sub	$16, %rsp

	mov	$0, %rax
	mov	$0, %rdi
	lea	-8(%rbp), %rsi
	mov	$8, %rdx
	syscall

    lea		-8(%rbp), %rsi
	mov 	$1, %rax
	mov 	$1, %rdi
	mov 	$8, %rdx
	syscall

	mov 	$60, %rax
	mov 	$0, %rdi
	syscall
