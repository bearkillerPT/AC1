# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1
# Sub-rotina terminal: não devem ser usados registos $sx
	.data
str:	.asciiz "201620"
	.eqv print_string,4
 	.eqv print_char, 11
 	.eqv print_int10,1
 	.eqv read_int, 5
	.text
	.globl main

main:	la $a0, str
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	jal atoi
	move $a0, $v0
	li $v0, print_int10
	syscall
	li $v0, 0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

atoi:	li $v0,0 # res = 0;
	move $t1, $a0
while: 	lb $t0, 0($t1) # while(*s >= ...)
 	blt $t0, '0', endwhile #
 	bgt $t0, '9', endwhile # {
	sub $t0, $t0, '0' # digit = *s – '0'
 	addiu $t1, $t1, 1 # s++;
 	mul $v0,$v0,10 # res = 10 * res;
 	add $v0, $v0, $t0 # res = 10 * res + digit;
 	j while # }
endwhile:jr $ra # termina sub-rotina 