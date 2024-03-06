.data
arr1: .word 1, 2, 3, 4, 5
arr2: .word 6, 7, 8, 9, 10
newline_msg: .string "The result is: "

.text
main:
    li s1, 5        # Set s1 to 5
    addi s2, x0, 0  # i = 0
    addi s3, x0, 0  # sum_of_products = 0
    la s4, arr1     # Load address of arr1 into s4
    la s5, arr2     # Load address of arr2 into s5

loop:
    bge s2, s1, exit_loop   # If i >= 5, exit the loop
    slli s6, s2, 2          # Calculate i * 4 (shift left by 2)
    
    add s7, s6, s4          # Calculate address of arr1[i]
    lw s8, 0(s7)            # Load value of arr1[i]
    
    add s9, s6, s5          # Calculate address of arr2[i]
    lw s10, 0(s9)           # Load value of arr2[i]
    
    mul s11, s8, s10        # Calculate arr1[i] * arr2[i]
    add s3, s3, s11         # Add arr1[i] * arr2[i] to sum_of_products
    
    addi s2, s2, 1          # i++
    j loop                  # Jump back to loop
    
exit_loop:
    # Print newline character
    addi a0, x0, 4
    la a1, newline_msg
    ecall
    
    # Print sum_of_products
    addi a0, x0, 1
    add a1, x0, s3
    ecall
    
    # Exit cleanly
    addi a0, x0, 10
    ecall
