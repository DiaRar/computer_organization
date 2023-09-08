print_num:     .asciz "%ld\n"
input_num:     .asciz "%ld"

.global main
main:
     push      %rbp
     mov       %rsp, %rbp

     sub       $16, %rsp
     mov       $input_num, %rdi
     lea       -8(%rbp), %rsi
     mov       $0, %rax
     call      scanf
     add       $8, %rsp

     mov       $1, %rax
     pop       %rdi
     call      factorial

     mov       $print_num, %rdi
     mov       %rax, %rsi
     mov       $0, %rax
     call      printf


     call      exit


factorial:
     test      %rdi, %rdi
     jz        .factorial_ret
     mul       %rdi
     dec       %rdi
     call      factorial
.factorial_ret:
     ret

exit:
     mov       $60, %rax
     mov       $0, %rdi
     syscall
     ret
