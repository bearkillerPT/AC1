	.data
str1: 	.asciiz "Introduza dois numeros: \n"
str2: 	.asciiz "Resultado: "
 	.eqv print_string,4
 	.eqv read_int, 5
 	.eqv print_char, 11
 	.eqv print_int16, 34
 	.eqv print_int10, 36
	.text
	.globl main

# Mapa de registos:
# $t0 – res
# $t1 – i
# $t2 - mdor
# $t3 - mdo

main:	la $a0, str1
	li $v0, print_string
	syscall
	li $v0, read_int
	syscall
	or $t2, $0, $v0
	andi $t2, $t2, 0x0F
	li $v0, read_int
	syscall
	or $t3, $0, $v0
	andi $t3, $t3, 0x0F
	ori $t1, $0, 0
	j while
	
while: 	sne $t4, $t2, $0 #flag modr!=0
	addi $t1, $t1, 1
	slti $t5, $t1, 4 #flag i++<4
	and $t6, $t4, $t5 #flag final (modr!=0 and flag i++<4)
	bne $t6, 1, endwhile
	andi $t6, $t2, 0x00000001
	bnez $t6, ifnez
	sll $t3, $t3, 1
	srl $t2, $t2, 1
	j while
	
#if( (mdor & 0x00000001) != 0 ) 
ifnez: 	add $t0, $t0, $t3
	sll $t3, $t3, 1
	srl $t2, $t2, 1
	j while
	
endwhile:
	la $a0, str2
	li $v0, print_string
	syscall
	or $a0, $0, $t0
	li $v0, print_int10
	syscall
	jr $ra
