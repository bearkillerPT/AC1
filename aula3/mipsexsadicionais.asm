	.data
str1: 	.asciiz "Introduza um numero: \n"
str2: 	.asciiz "\nValor em código Gray: "
str3: 	.asciiz "\nValor em binario: "
 	.eqv print_string,4
 	.eqv read_int, 5
 	.eqv print_char, 11
 	.eqv print_int16, 34
 	.eqv print_int2, 35
	.text
	.globl main

# Mapa de registos:
# $t0 – gray
# $t1 – mask
# $t2 - bin

main:	la $a0, str1
	li $v0, print_string
	syscall
	li $v0, read_int
	syscall
	or $t0, $0, $v0
	srl $t1, $t0, 1
	or $t2, $0, $t0
	j while
	
while:	beqz $t1, endwhile
	xor $t2, $t2, $t1
	srl $t1, $t1, 1
	j while

endwhile:
	la $a0, str2
	li $v0, print_string
	syscall
	or $a0, $0, $t0
	li $v0, print_int2
	syscall
	la $a0, str3
	li $v0, print_string
	syscall
	or $a0, $0, $t2
	li $v0, print_int2
	syscall
	jr $ra
	
	#help verificar dados?
