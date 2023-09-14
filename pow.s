print_num:     .asciz "%ld\n"
input_num:     .asciz "%ld%ld"
.global main
main:
     push      %rbp
     mov       %rsp, %rbp

     sub       $16, %rsp      # Making space for 2 input values

     mov       $input_num, %rdi
     lea       -8(%rbp), %rsi # Loading the address of the first value
     lea       -16(%rbp), %rdx # Loading the address of the second value
     mov       $0, %rax
     call      scanf


     pop       %rsi      # Popping the second parameter
     pop       %rdi      # Popping the first parameter

     call      pow

     mov       $print_num, %rdi
     mov       %rax, %rsi
     mov       $0, %rax
     call      printf    # Printing the return value of pow
     call      exit


 pow:
      push      %rbp           # Boilerplate cuz of convention
      mov       %rsp, %rbp

      mov       $1, %rax
 .loop:
      test      %rsi, %rsi     # Setting the ZF (Zero Flag)
      jz        .loop_end      # Checking if ZF is 0
      mul       %rdi           # Multiplying RAX by RDI
      dec       %rsi           # Decreasing RSI
      jmp       .loop
 .loop_end:
      mov       %rbp, %rsp     # More boilerplate
      pop       %rbp
      ret
     
#pow_fast:
#     push      %rbp           # Boilerplate cuz of convention
#     mov       %rsp, %rbp
#
#    mov       %rdi, %rax
#     dec       %rsi
#.loop:
#     test      %rsi, %rsi     # Setting the ZF (Zero Flag)
#     jz        .loop_end      # Checking if ZF is 0
#
#     and       $1, %rsi
#     jz        .even
#     
#     mul       %rdi           # Multiplying RAX by RDI
#     dec       %rsi
#     test      %rsi, %rsi     # Setting the ZF (Zero Flag)
#     jz        .loop_end      # Checking if ZF is 0

#.even:

#    shr       $1, %rsi
#     mul       %rax
#     jmp       .loop

#.loop_end:

#     mov       %rbp, %rsp     # More boilerplate
#     pop       %rbp
#     ret
