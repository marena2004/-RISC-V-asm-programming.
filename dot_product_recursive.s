.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
msg_text: .asciiz "The dot product is: "

.text
main:
    la t0, a          # Load address of array a
    la t1, b          # Load address of array b
    
    li a1, 5          # a1 = size
    addi a2, zero, 0  # i = 0
    addi a3, zero, 0  # sop = 0



dot_product_recursive:
    bge a2, a1, exit # If i >= size, exit loop

    # Load values from arrays a and b
    slli x7, a2, 2    # Calculate offset
    add x9, x7, t0   # Calculate address of a[i]
    lw x22, 0(x9)     # Load a[i]

    add x20, x7, t1   # Calculate address of b[i]
    lw x23, 0(x20)     # Load b[i]

    # Calculate dot product
    mul x21, x22, x23  # a[i] * b[i]
    add a3, a3, x21    # Add to dot product

    addi a2, a2, 1     # i++
    j dot_product_recursive

exit:
    # Print message
    addi a0, zero, 4       # Print string
    la a1, msg_text
    ecall

    # Print dot product
    addi a0, zero, 1       # Print integer
    add a1, zero, a3
    ecall

    # Exit cleanly
    addi a0, zero, 10      
    ecall
