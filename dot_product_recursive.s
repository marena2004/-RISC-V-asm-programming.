.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .asciiz "The dot product is: "

.text
.globl main
main:
    # Initialize registers
    addi t0, x0, 5         # t0 = size = 5
    la t1, a               # t1 = &a[0]
    la t2, b               # t2 = &b[0]
    addi t3, x0, 0         # t3 = result = 0
    
    # Call dot_product_recursive
    call dot_product_recursive
    
    # Print result
    addi a0, x0, 4         # Print string system call
    la a1, newline         # Load address of newline
    ecall
    
    addi a0, x0, 1         # Print integer system call
    mv a1, t3              # Load result into a1
    ecall
    
    # Exit program
    addi a0, x0, 10        # Exit system call
    ecall

dot_product_recursive:
    # Function prologue
    addi sp, sp, -16       # Adjust stack pointer
    sw ra, 0(sp)           # Save return address
    sw s0, 4(sp)           # Save s0
    
    # Function body
    lw s0, 0(a)            # Load a[0] into s0
    lw t4, 0(b)            # Load b[0] into t4
    mul t5, s0, t4         # t5 = a[0] * b[0]
    addi a, a, 4           # Increment a pointer
    addi b, b, 4           # Increment b pointer
    addi a1, a1, -1        # Decrement size
    
    bnez a1, recursive_call  # Branch if size != 0
    
    # Base case: size == 0, return
    mv a0, t5              # Move result to a0
    j return
    
recursive_call:
    call dot_product_recursive  # Recursive call
    lw t6, 0(a)            # Load a[0] into t6
    lw t7, 0(b)            # Load b[0] into t7
    mul t8, t6, t7         # t8 = a[0] * b[0]
    add t3, t5, t8         # result += a[0] * b[0]
    
return:
    # Function epilogue
    lw ra, 0(sp)           # Restore return address
    lw s0, 4(sp)           # Restore s0
    addi sp, sp, 16        # Restore stack pointer
    ret
