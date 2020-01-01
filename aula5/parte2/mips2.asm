# Mapa de registos
# array: $t0
# pultimo: $t1
# array[i]: $a0
#
 	.data
array: 	.word str1,str2,str3
str1: 	.asciiz "Array"
str2: 	.asciiz "de"
str3: 	.asciiz "ponteiros"
 	.eqv print_string,4
 	.eqv print_char,11
 	.eqv SIZE,3
 	.text
 	.globl main
main: 	la $t0,array # $t0 = &(array[0]);
 	li $t1, SIZE # pultimo = SIZE
 	sll $t1, $t1, 2 #pultimo += 4
 	addu $t1, $t1, $t0 #pultimo = array[SIZE]
for: 	bge $t0,$t1,endw # while(i < SIZE) {
 	lw $a0, 0($t0)
 	li $v0, print_string
 	syscall
 	ori $a0, $0, '\n'
 	li $v0, print_char
 	syscall
 	addi $t0, $t0,4
 	j for
 	
endw: jr $ra
