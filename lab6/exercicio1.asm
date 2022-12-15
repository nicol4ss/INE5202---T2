main:

    jal read_a
    jal read_b
    jal solve
    jal print

solve:
    addi $t0, $zero, -1
    mul $t1, $a2, $t0
    div $t3, $t1, $a1
    jr $ra

read_a:
    li $v0, 5
    syscall
    move $a1, $v0
    jr $ra

read_b:
    li $v0, 5
    syscall
    move $a2, $v0
    jr $ra

print:
    li $v0, 1
    move $a0, $t3
    syscall