.data
newline: .string "\n"

.text
.globl main
main:
    # Call mult function
    addi a0, x0, 110   # Load argument a
    addi a1, x0, 50    # Load argument b
    call mult          # Call mult function
    
    # Print result
    addi a0, x0, 1     # Print integer system call
    ecall
    
    # Print newline
    addi a0, x0, 4     # Print string system call
    la a1, newline     # Load address of newline
    ecall
    
    # Exit program
    addi a0, x0, 10    # Exit system call
    ecall

mult:
    # Function prologue
    addi sp, sp, -16   # Adjust stack pointer
    sw ra, 0(sp)       # Save return address
    sw s0, 4(sp)       # Save s0
    
    # Function body
    lw s0, 0(a0)       # Load a into s0
    lw t1, 0(a1)       # Load b into t1
    
    beq t1, x0, return_base  # Base case: if b == 0, return 0
    
    addi t1, t1, -1    # Decrement b
    call mult          # Recursive call
    add a0, s0, a0     # a + mult(a, b-1)
    
    j return
    
return_base:
    mv a0, s0          # Return a
    
return:
    # Function epilogue
    lw ra, 0(sp)       # Restore return address
    lw s0, 4(sp)       # Restore s0
    addi sp, sp, 16    # Restore stack pointer
    ret
