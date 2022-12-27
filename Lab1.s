main:
addiu $s0, $0, 10
addiu $s1, $0, 3

loop:
slt $t1, $s0, $s1
bne $t1, $0, done
nop
subu $s0, $s0, $s1
j loop
nop

done:
addu $s2, $0, $s0