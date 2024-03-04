.data
array1: .word 1, 2, 3, 4, 5
array2: .word 6, 7, 8, 9, 10
newline_msg: .string "The dot product is: "

.text
main:
    li t0, 5          # t0 = 5 (loop counter)
    addi t1, zero, 0  # t1 = i = 0 (loop index)
    addi t2, zero, 0  # t2 = sum_of_products = 0
    la t3, array1     # Load the address of array1 into t3
    la t4, array2     # Load the address of array2 into t4

loop:
    bge t1, t0, exit  # If i >= 5, exit the loop
    # Load array elements
    slli t5, t1, 2    # t5 = i*4 (byte offset)
    add t6, t5, t3    # t6 = &array1[i]
    lw t7, 0(t6)      # t7 = array1[i]
    add t8, t5, t4    # t8 = &array2[i]
    lw t9, 0(t8)      # t9 = array2[i]
    # Calculate dot product
    mul t10, t7, t9   # t10 = array1[i] * array2[i]
    add t2, t2, t10   # sum_of_products += array1[i] * array2[i]
    addi t1, t1, 1    # Increment i
    j loop

exit:
    # Print newline
    addi a0, zero, 4       # Print string system call
    la a1, newline_msg     # Load address of newline_msg
    ecall

    # Print sum_of_products
    addi a0, zero, 1  # Print integer system call
    add a1, zero, t2  # Load sum_of_products into a1
    ecall

    # Exit cleanly
    addi a0, zero, 10  # Exit system call
    ecall