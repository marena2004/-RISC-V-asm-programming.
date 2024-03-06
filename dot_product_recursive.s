    .text
    .align 2

dot_product_recursive:
    addi    sp, sp, -16             # Adjust stack pointer
    sw      s0, 0(sp)               # Save s0
    sw      s1, 4(sp)               # Save s1
    sw      s2, 8(sp)               # Save s2

    mv      s0, a0                  # Move pointer a to s0
    mv      s1, a1                  # Move pointer b to s1
    mv      s2, a2                  # Move size to s2

    li      t0, 1                   # Load immediate 1 into t0
    beq     s2, t0, end_recursive   # If size is 1, jump to end_recursive

    lw      a0, 0(s0)               # Load *a into a0
    lw      a1, 0(s1)               # Load *b into a1
    mul     a0, a0, a1              # Multiply a0 and a1
    addi    s0, s0, 4               # Increment pointer a
    addi    s1, s1, 4               # Increment pointer b
    addi    s2, s2, -1              # Decrement size

    jal     ra, dot_product_recursive   # Recursive call

    lw      s0, 0(sp)               # Restore s0
    lw      s1, 4(sp)               # Restore s1
    lw      s2, 8(sp)               # Restore s2
    addi    sp, sp, 12              # Restore stack pointer
    add     a0, a0, a1              # Add current result with the previous one
    ret

end_recursive:
    lw      a0, 0(s0)               # Load *a into a0
    lw      a1, 0(s1)               # Load *b into a1
    mul     a0, a0, a1              # Multiply a0 and a1
    ret
