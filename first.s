.data
.globl hello
hello:
.string "Hello World!\n"

.global main

main:
        pushq   %rbp
        movq    %rsp, %rbp
        
        movq    $0, %rax
        movq    $hello, %rdi
        call    puts
        
        movq    %rbp, %rsp
        popq    %rbp
end:
        movq    $0, %rsp
        call    exit
        