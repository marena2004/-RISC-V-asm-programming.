.data
array_a: .word 1, 2, 3, 4, 5
array_b: .word 6, 7, 8, 9, 10
output_message: .asciiz "The dot product is: "

.text
main:
    # s0 = array_a, s1 = array_b, s2 = size
    la s0, array_a
    la s1, array_b
    li s2, 5
    jal dot_product_recursive # Call dot_product_recursive
    mv a1, s0                # Move result to a1 for printing
    li a0, 1                 # Load system call code for printing integer
    ecall                    # Print the integer result

    li a0, 10                # Load system call code for exit
    ecall                    # Exit the program

dot_product_recursive:
    addi sp, sp, -16         # Prepare Stack Pointer
    sw ra, 0(sp)             # Save ra into stack
    sw s0, 4(sp)             # Save s0 into stack
    sw s1, 8(sp)             # Save s1 into stack
    sw s2, 12(sp)            # Save s2 into stack

    li t0, 1                 # Load immediate 1
    bne s2, t0, recursive_call # If size != 1, jump to recursive_call

    # Base Case
    lw s0, 0(s0)             # Load a[0] into s0
    lw s1, 0(s1)             # Load b[0] into s1
    mul s0, s0, s1           # Calculate a[0]*b[0]
    j end_recursive          # Jump to end_recursive

recursive_call:
    addi s0, s0, 4           # Increment a pointer
    addi s1, s1, 4           # Increment b pointer
    addi s2, s2, -1          # Decrement size
    jal dot_product_recursive # Recursive call

    lw ra, 0(sp)             # Restore ra
    lw s0, 4(sp)             # Restore s0
    lw s1, 8(sp)             # Restore s1
    lw s2, 12(sp)            # Restore s2

    lw t1, 0(s0)             # Load a[0] into t1
    lw t2, 0(s1)             # Load b[0] into t2
    mul t1, t1, t2           # Calculate a[0]*b[0]
    add s0, s0, t1           # Add to result
    j end_recursive          # Jump to end_recursive

end_recursive:
    lw ra, 0(sp)             # Restore ra
    addi sp, sp, 16          # Restore stack pointer
    jr ra                    # Return to caller

exit:
    mv a0, s0                # Move the result to a0

    li a7, 4                 # Load system call code for printing string into a7
    la a1, output_message    # Load the address of the string to print into a1
    ecall                    # Print the string

    mv a1, s0                # Move the result to be printed to a1
    li a0, 1                 # Load system call code for printing integer into a7
    ecall                    # Print the integer

    li a0, 10                # Load system call code for exit into a0
    li a7, 93                # Load system call code for exit into a7
    ecall                    # Exit the program
