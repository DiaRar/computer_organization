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

     mov       $input_num, %rdi
     lea       -16(%rbp),§ %rsi
     mov       $0, %rax
     call      scanf

     pop       %rsi
     pop       %rdi

     call      pow

     mov       $print_num, %rdi
     mov       %rax, %rsi
     mov       $0, %rax
     call      printf


     call      exit


pow:
     mov       $1, %rax
.loop:
     test      %rsi, %rsi
     jz        .loop_end
     mul       %rdi
     dec       %rsi
     jmp       .loop
.loop_end:
     ret

exit:
     mov       $60, %rax
     mov       $0, %rdi
     syscall
     ret