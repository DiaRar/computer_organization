
.bss
number:  .quad
.text
input:  .asciz "%ld"
output:  .asciz "%ld\n"
.global main
main:
    push    %rbp
    mov     %rsp, %rbp

    mov     $input, %rdi
    mov     $number, %rsi
    mov     $0, %rax
    call    scanf

    mov     $output, %rdi
    mov     number, %rsi
    mov     $0, %rax
    call    printf

    call    exit
