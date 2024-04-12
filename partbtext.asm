.data

MYARRAY: .word 1, 1, 1, 1, 1, 1, 1, 8, 9, 10
INPUT_A1_START: .word 0
INPUT_A2_END: .word 8

Prompt: .asciiz "\n$a2 contains: "
Return: .asciiz "\n"

.text
main:
la $a3 MYARRAY
la $a1 INPUT_A1_START
lw $a1 0($a1)
la $a2 INPUT_A2_END
lw $a2 0($a2)

# Or you could have li $a2 ... and li $a3 ... 

jal loopArray
move $a2, $s0
jal codeContinue


addIndex:
add $s0, $s0, $a1 
add $a1, $a1, 1
slt $v0, $a1, $a2
bne $v0, $zero, loopArray
jr $31
nop

loopArray:
mul $t0, $a1, 4
add $t0, $t0, $a3
lw $t0, 0($t0)
div $t1, $t0, 2
mfhi $t1
bne $t1, $zero, addIndex
add $a1, $a1, 1
slt $v0, $a1, $a2
bne $v0, $zero, loopArray
jr $31
nop

codeContinue:

###### Your code ends

# Printout
la $a0,Prompt
li $v0 4
syscall

li $v0 1
move $a0 $a2
syscall # print $a2

la $a0, Return
li $v0 4
syscall 

li $v0 10
syscall # exit
# End of program
