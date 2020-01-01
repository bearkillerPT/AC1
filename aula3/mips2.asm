# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
 	.data
str1: 	.asciiz "Introduza um numero: \n"
str2: 	.asciiz "O valor em binário e: \n"
 	.eqv print_string,4
 	.eqv read_int, 5
 	.eqv print_char, 11
 	.text
 	.globl main
 	
main: 	la $a0, str1
	li $v0, print_string
	syscall
	
	li $v0, read_int
	syscall
	or $t0, $0, $v0
	or $t2, $0, $0
	j calc
	
calc:	bgt $t2, 31, endapp
	andi $t1, $t0, 0x80000000
	rem $t3, $t2, 4
	beqz $t3 print_space
	bnez $t1, print1
	beqz $t1, print0
	
endcal: addi $t2, $t2, 1
	sll $t0, $t0, 1
	j calc
		
print1:	ori $a0, $0, '1'
	li $v0, print_char
	syscall
	j endcal

print0:	ori $a0, $0, '0'
	li $v0, print_char
	syscall
	j endcal

print_space:
	ori $a0, $0, ' '
	li $v0, print_char
	syscall
	bnez $t1, print1
	beqz $t1, print0
	j calc
			
endapp: jr $ra
