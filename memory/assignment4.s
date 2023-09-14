.text

.include "final.s"
output: .asciz "%d\n"
output_char: .asciz "%c"
color: .asciz "\033"
foreground: .asciz "[38;5;"
background: .asciz ";48;5;"
end_of_change: .asciz "m"
number_of_color: .asciz "%d"
special_effect_start: .asciz "["
.global main
# ************************************************************
# Subroutine: decode                                         *
# Description: decodes message as defined in Assignment 3    *
#   - 2 byte unknown                                         *
#   - 4 byte index                                           *
#   - 1 byte amount                                          *
#   - 1 byte character                                       *
# Parameters:                                                *
#   first: the address of the message to read                *
#   return: no return value                                  *
# ************************************************************

print_color:
	push	%rbp
	mov 	%rsp, %rbp

    push    %rsi
	push	%rdi
	

	mov		$color, %rdi
	mov		$0, %rax
	call 	printf

	mov		$foreground, %rdi
	mov		$0, %rax
	call 	printf

	mov		$number_of_color, %rdi
	pop		%rsi
	mov 	$0, %rax
	call	printf

    mov		$background, %rdi
	mov		$0, %rax
	call 	printf

	mov		$number_of_color, %rdi
	pop		%rsi
	mov 	$0, %rax
	call	printf

	mov		$end_of_change, %rdi
	mov		$0, %rax
	call 	printf

	mov		%rbp, %rsp
	pop 	%rbp
	ret
special_effect:
    push    %rbp
    mov     %rsp, %rbp

    push    %rdi
    mov     $special_effect_start, %rdi
    mov     $0, %rax
    call    printf


    mov     %rbp, %rsp
    pop     %rbp
    ret

decode:
	# prologue
	pushq	%rbp 			# push the base pointer (and align the stack)
	movq	%rsp, %rbp		# copy stack pointer value to base pointer
	# your code goes here

	push	%rbx 	# Pushing callee-saved registers to stack to restore them
	push 	%r12	# in the epilogue
	push	%r13
	push	%r14
	
    mov 	%rdi, %rbx
    mov 	$0, %rcx
start_loop:
    mov 	(%rbx, %rcx, 8), %r12 	# %r12 = MESSAGE[%rcx]
	mov 	%r12b, %r13b			# Moving the char
	shr 	$8, %r12				# Shifting the char

	mov		%r12, %r14
	shr		$40, %r14
	mov		$0, %rdi
    mov		%r14b, %dil
    shr		$8, %r14
    cmp     %r14b, %dil
    je      special_effect_conditional
	mov 	$0, %rsi
	mov		%r14b, %sil
	call	print_color
    jmp     special_effect_end
special_effect_conditional:
    call    special_effect
special_effect_end:
loop:
	test 	%r12b, %r12b			# Setting ZF (Zero Flag)
	jz 		jump_loop				# Jumping if ZF

	mov 	$output_char, %rdi
	mov 	%r13b, %sil				# Putting the letter in sil
	mov		$0, %rax				# Not using xmm.. registers
	call 	printf					# Calling printf
	dec		%r12b					# Decrementing the number of prints
	jmp		loop
jump_loop:
	shr 	$8, %r12
	mov		%r12d, %ecx				# Moving the 4 bytes containing the 
	test	%ecx, %ecx				# next address
	jnz		start_loop				# Jumping if not ZF
	# epilogue

	pop		%r14
	pop		%r13					# Restoring the callee saved registers
	pop		%r12
	pop		%rbx

	movq	%rbp, %rsp		# clear local variables from stack
	popq	%rbp			# restore base pointer location 
	ret

main:
	pushq	%rbp 			# push the base pointer (and align the stack)
	movq	%rsp, %rbp		# copy stack pointer value to base pointer

	movq	$MESSAGE, %rdi	# first parameter: address of the message
	call	decode			# call decode

	popq	%rbp			# restore base pointer location 
	movq	$0, %rdi		# load program exit code
	call	exit			# exit the program

