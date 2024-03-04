.text
main:
    addi t0, x0, 110    # t0 = a
    addi t1, x0, 50     # t1 = b
    jal mult_recursive  # Call mult_recursive

    mv a1, a0           # Move result to a1 for printing
    addi a0, x0, 1      # Print integer system call
    ecall
    
    addi a0, x0, 10     # Exit cleanly
    ecall

    
mult_recursive:
    addi t2, x0, 1      # Base case: check if b is 1
    beq t1, t2, exit_base_case
    
    addi sp, sp, -4     # Save return address
    sw ra, 0(sp)        # Store ra on the stack
    
    addi sp, sp, -4     # Save a0
    sw a0, 0(sp)
    
    addi t1, t1, -1     # Decrease b for the recursive call
    jal mult_recursive
    
    lw t3, 0(sp)        # Restore a0
    addi sp, sp, 4
    
    add t0, t0, t3      # Calculate a + mult(a, b-1)
    
    lw ra, 0(sp)        # Restore ra
    addi sp, sp, 4      # Restore stack pointer
    jr ra               # Return

exit_base_case:
    mv a0, t0           # Return a (the result)
    jr ra               # Return
