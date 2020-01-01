	
	.eqv print_char, 11
	.eqv print_string, 4
	.eqv print_int10, 1
	.data
quociente:.asciiz "Quociente: "
resto:	.asciiz "Resto:	"
	.text
	.globl main

main:	subu $sp, $sp, 8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	li $a0, 0x8001
	li $a1,	3
	jal divc
	move $s0, $v0
	la $a0, quociente
	li $v0, print_string
	syscall
	andi $a0, $s0, 0x0000FFFF
	li $v0, print_int10
	syscall
	li $a0, '\n'
	li $v0, print_char
	syscall
	la $a0, resto
	li $v0, print_string
	syscall
	andi $a0, $s0, 0xFFFF0000
	srl $a0, $a0, 16
	li $v0, print_int10
	syscall
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	li $v0, 0
	jr $ra


divc:	li $t0, 0 #t0 -> i
	li $t1, 0 #t1 -> bit
	li $t2, 0 #t2 -> quociente
	li $t3, 0 #t3 -> resto
	sll $a1, $a1, 16
	andi $a0, $a0, 0xFFFF
	sll $a0, $a0, 1
for:	bge $t0, 16, endfor
	li $t1, 0
	blt $a0, $a1, else
	sub $a0, $a0, $a1
	li $t1, 1
else:	sll $a0, $a0, 1
	or $a0, $a0, $t1
	addi $t0, $t0, 1
	j for
endfor:	srl $t3, $a0, 1
	andi $t3, $t3, 0xFFFF0000
	andi $t2, $a0, 0x0000FFFF
	move $v0, $t3
	or $v0, $v0, $t2
	jr $ra
	
