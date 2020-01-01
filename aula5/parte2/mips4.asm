# Mapa de registos
#i : $t0
#

 	.data
str1: 	.asciiz "Nr. de parametros: "
str2: 	.asciiz "\nP"
str3: 	.asciiz ": "
 	.eqv print_string,4
 	.eqv print_int10,1
 	.text
 	.globl main
main: 	li $t0, 0 # i = 0
	or $s0, $a0, $0 # $s0 = argc
	or $s1, $a1, $0 # $s1 = &argv
	la $a0, str1
	li $v0, print_string
	syscall
	or $a0, $s0, $0
	li $v0, print_int10
	syscall
for:	bge $t0, $s0, endfor
	la $a0, str2 
	li $v0, print_string
	syscall
	or $a0, $t0, $0
	li $v0, print_int10
	syscall
	la $a0, str3
	li $v0, print_string
	syscall
	sll $t1, $t0, 2
	addu $a0, $t1, $s1
	lw $a0, 0($a0)
	li $v0, print_string
	syscall
	addi $t0, $t0, 1
	j for
endfor:	li $v0, 0
	jr $ra
