main:
lui $s0, 0x0001
ori $s0, $s0, 0xF000
addiu $s1, $0, 0
addiu $s2, $0, 0
addiu $t2, $0, 10
addiu $t3, $0, 30

loop:
slt $t0, $s1, $t2
beq $t0, $0, done
nop
sll $t0, $s1, 2
addu $t0, $t0, $s0

lw $t1, 0($t0)
slt $t4, $s2, $t3
beq $t4, $0, jump
nop
addu $s2, $s2, $s1

jump:
addu $t1, $t1, $s2
sw $t1, 0($t0)
addiu $s1, $s1, 1
nop

j loop
nop

done: