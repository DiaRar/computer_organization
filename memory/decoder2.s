.text

.include "final.s"
output: .asciz "%c"

output_color: .asciz "\033"
output_background: .asciz "[48;5;"
output_foreground: .asciz "[38;5;"
output_number: .asciz "%d"

output_endcolor: .asciz "m"

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
foreground:
    push %rbp
    mov %rsp, %rbp

    push %rdi
    
    mov $output_color, %rdi
    mov $0, %rax
    call printf

    mov $output_foreground, %rdi
    mov $0, %rax
    call printf

    mov $output_number, %rdi
    pop %rsi
    mov $0, %rax
    call printf

    mov $output_endcolor, %rdi
    mov $0, %rax
    call printf

    mov %rbp, %rsp
    pop %rbp

    ret
background:
    push %rbp
    mov %rsp, %rbp

    push %rdi
    
    mov $output_color, %rdi
    mov $0, %rax
    call printf

    mov $output_background, %rdi
    mov $0, %rax
    call printf

    mov $output_number, %rdi
    pop %rsi
    mov $0, %rax
    call printf

    mov $output_endcolor, %rdi
    mov $0, %rax
    call printf

    mov %rbp, %rsp
    pop %rbp
    ret
decode:
	# prologue
	pushq	%rbp 			# push the base pointer (and align the stack)
	movq	%rsp, %rbp		# copy stack pointer value to base pointer

	# your code goes here
    sub $8, %rsp
    push %rbx
    push %r12
    push %r13
    push %r14
    push %r15
    mov %rdi, %rbx # pun mesajul in rbx

    mov $0, %rcx  # linia pe care ma aflu
    big_loop:
        mov (%rbx, %rcx, 8), %r12 # pun in r12 continutul liniei respective
        mov %r12, %r14
        
        shr $48, %r14
        mov %r14, %r15
        shr $8, %r15
        mov $0, %rdi
        mov %r14b, %dil
        
        cmp %r14b, %r15b
        je special_effect

        call foreground
        shr $8, %r14
        mov $0, %rdi
        mov %r14b, %dil
        call background
        jmp end_special_effect

        special_effect:
        
        end_special_effect:

        mov %r12b, %r13b  # r13b e litera 

        shr $8, %r12 #shiftez la dreapta mesajul ca sa scot litera
        # in r12b am acum numarul de ori de care afisez litera
        loop:
            cmp $0, %r12b
            je  endloop

            mov $0, %rax
            mov $output, %rdi
            mov %r13b, %sil # afisez litera
            call printf

            dec %r12b
            jmp loop
        endloop:
            shr $8, %r12
            mov %r12d, %ecx # randul pe care ma mut
        cmp $0, %ecx
        jne big_loop
    # epilogue
	pop %r15
    pop %r14
    pop %r13
    pop %r12
    pop %rbx
    add $8, %rsp
    
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