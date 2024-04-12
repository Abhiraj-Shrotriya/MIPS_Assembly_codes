.data
Prompt1: .asciiz "$a1 contains: "
Prompt2: .asciiz "\n$a2 contains: "
Return: .asciiz "\n"

.text
main:
lui $a3, 4096 # We are going to save inputs to the start of the user data segment
li $a2 70
sw $a2 0($a3) # Save x
li $a2 4
sw $a2 4($a3) # Save y
li $a2 17
sw $a2 8($a3) # Save z
li $a2 17
sw $a2 12($a3) # Save w

# loading registers with values of x,y,z,w and 12

lw $t0, 0($a3) # loading x in register t0
lw $t1, 4($a3) # loading y in register t1
lw $t2, 8($a3) # loading z in register t2
lw $t3, 12($a3) # loading w in register t3
addiu $t9, $zero, 12 # loading literal 12 in register t9

# calculation of exression 1 - (w+z)-(x*y)

mul $v0, $t0, $t1 # (x*y)
add $v1, $t2, $t3 # (w+z)
sub $a1, $v1, $v0 

# calculation of expression 2 - (((y*12)/4)%((x-w)/2))

mul $v0, $t1, $t9 # (y*12)
srl $v0, $v0, 2 # ((y*12)/4)
sub $v1, $t0, $t3 #(x-w)
abs $v1, $v1 # magnitude of (x-w)
srl $v1, $v1, 1 # (x-w)/2
div $a2, $v0, $v1 # %
mfhi $a2 # %

##### Start of diagnostics
la $a0,Prompt1
li $v0,4
syscall

li $v0 1
move $a0 $a1
syscall # print $a1

la $a0,Prompt2
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
