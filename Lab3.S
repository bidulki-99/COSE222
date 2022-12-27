addiu $sp, $0, 0x1000    # stack pointer
addiu $s0, $0, 5       # input
j main
nop

# multiplication
mult:
  addiu $v0, $0, 0
  addiu $t0, $0, 0
multloop:
  slt $t1, $t0, $a1
  beq $t1, $0, multreturn
  nop
  addu $v0, $v0, $a0
  addiu $t0, $t0, 1
  j multloop
  nop
multreturn:
  jr $ra
  nop

fact:
  addiu $sp, $sp, -4
  sw $ra, 0($sp)
  addiu $a1, $s0, -1
  addiu $v1, $0, 1
  nop
factloop:
  slt $t1, $0, $a1
  beq $t1, $0, factreturn
  nop
  jal mult
  nop
  addu $v1, $0, $v0
  addu $a0, $0, $v1
  addiu $a1, $a1, -1
  j factloop
  nop
factreturn:
  lw $ra, 0($sp)
  addiu $sp, $sp, 4
  jr $ra
  nop

main:
# implement your algorithm here replacing following lines
  addu $a0, $0, $s0
  jal fact
  nop
  addu $s1, $0, $v1       # output
