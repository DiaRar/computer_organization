print_num:     .asciz "%lu\n"
input_num:     .asciz "%lu"

.global main
main:
     push      %rbp
     mov       %rsp, %rbp

     sub       $16, %rsp
     mov       $input_num, %rdi
     lea       -16(%rbp), %rsi
     mov       $0, %rax
     call      scanf
     
     mov       -16(%rbp), %rdi
     

     call      factorial
     mov       $print_num, %rdi
     mov       %rax, %rsi
     mov       $0, %rax
     call      printf
     call      exit


factorial:
     test      %rdi, %rdi
     jz        .factorial_ret
     push      %rdi
     dec       %rdi
     call      factorial
     pop       %rdi
     mul       %rdi
     ret
.factorial_ret:
     mov       $1, %rax
     ret

