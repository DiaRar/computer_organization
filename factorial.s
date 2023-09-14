print_num:     .asciz "%lu\n"
input_num:     .asciz "%lu"
.global main
main:
     push      %rbp                # Boilerplate, setting base pointer
     mov       %rsp, %rbp

     sub       $16, %rsp           # Making space for 2 numbers, as we need the
                                   # stack to be 16-byte aligned
     mov       $input_num, %rdi
     lea       -8(%rbp), %rsi      # Moving the address into rsi
     mov       $0, %rax
     call      scanf               # Calling C-standard library scanf
     
     mov       -8(%rbp), %rdi      # Copying the value into the first param
     call      factorial

     mov       $print_num, %rdi
     mov       %rax, %rsi
     mov       $0, %rax
     call      printf

     call      exit


factorial:
     test      %rdi, %rdi          # Setting the ZF (Zero Flag)
     jz       .factorial_ret       # Jumping if ZF is 0
     push      %rdi                # Pushing %rdi on the stack
     dec       %rdi
     call      factorial    # Calling factorial(%rdi-1)
     pop       %rdi                # Popping old %rdi
     mul       %rdi
     ret
.factorial_ret:
     mov       $1, %rax            # Setting first %rax to 1
     ret

