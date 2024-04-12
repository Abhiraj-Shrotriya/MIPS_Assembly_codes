.data

# Some test values 
# Task 0: code point to 3-byte UTF-8: INPUT 0x8a9e OUTPUT 0x9eaae8
# Task 1: 3-byte UTF-8 to code point: INPUT 0x9eaae8 OUTPUT 0x8a9e
# Task 2: code point to 4-byte UTF-8: INPUT 0x2a731 OUTPUT 0xb19caaf0
# Task 3: 4-byte UTF-8 to code point: INPUT 0xb19caaf0 OUTPUT 0x2a731


INPUT: .word 0x9eaae8
TARGET: .word 0x8a9e

SUCCESS_MSG: .asciiz "Test successful\n"
FAIL_MSG: .asciiz "Test failed\n"
.text
main:
la $a3 INPUT
lw $a3 0($a3) 

# extracting lowest order byte

srl $t0, $a3, 16
sll $t9, $t0, 16
subu $t0, $t0, 0x80

# extracting middle byte

subu $t1, $a3, $t9
srl $t1, $t1, 8
sll $t1, $t1, 8
move $t8, $t1
subu $t1, $t1, 0x8000
srl $t1, $t1, 2

# extracting highest order byte

subu $t2, $a3, $t8
subu $t2, $t2, $t9
sll $t2, $t2, 16
subu $t2, $t2, 0xe00000
srl $t2, $t2, 4

# calulating result

add $a2, $t0, $t1
add $a2, $a2, $t2

###### your code ends
la $a3 TARGET
lw $a3 0($a3)

beq $a2 $a3 SUCCESS
la $a0, FAIL_MSG
li $v0 4
syscall
b END

SUCCESS:
la $a0, SUCCESS_MSG
li $v0 4
syscall

END:
li $v0 10
syscall # exit
# End of program