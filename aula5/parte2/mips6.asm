# Mapa de registos
#&array[i]: $t0
#&arra[size]: $t1
# str: $t2
#str[i] : $t3
#i : $t5

 	.data
array: 	.word str1,str2,str3
str1: 	.asciiz "Array"
str2: 	.asciiz "de"
str3: 	.asciiz "ponteiros"
str4:	.asciiz "\nString #"
str5:	.asciiz ": "
 	.eqv print_string,4
 	.eqv print_int10,1
 	.eqv print_char, 11
 	.eqv SIZE,3
 	.text
 	.globl main
main: 	la $t0,array # $t0 = &(array[0]);
	li $t1, SIZE
	sll $t1, $t1, 2 
	addu $t1, $t1, $t0
	li $t5, 1
for: 	bge $t0, $t1, endfor
	la $a0, str4
	li $v0, print_string
	syscall
	or $a0, $0, $t5
	li $v0, print_int10
	syscall
	la $a0, str5
	li $v0, print_string
	syscall
	lw $t2, 0($t0)
	lb $t3, 0($t2)
while:	beq $t3, '\0', endw	
	or $a0, $0, $t3
	li $v0, print_char
	syscall
	li $a0, '-'
	li $v0, print_char
	syscall
	addiu $t2, $t2, 1
	lb $t3, 0($t2)
	j while
endw:	addiu $t0, $t0, 4
	addi $t5, $t5, 1
	j for
endfor:	jr $ra
 	
