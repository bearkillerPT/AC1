# Mapa de registos:
# str: $a0 -> $s0 (argumento � passado em $a0)
# p1: $s1 (registo callee-saved)
# p2: $s2 (registo callee-saved)
#
	.data
str:	.asciiz "ITED - orievA ed edadisrevinU"
	.eqv print_string,4
 	.eqv print_char, 11
 	.eqv print_int10,1
	.text
	.globl main

main:	la $a0, str
	subu $sp, $sp, 4 # reserva espa�o na stack
	sw $ra,0($sp) #guarda endere�o de retorno
	jal strrev
	la $a0, str
	li $v0, print_string
	syscall
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	li $v0, 0 # return 0
	jr $ra

strrev: subu $sp,$sp,16 # reserva espa�o na stack
 	sw $ra,0($sp) # guarda endere�o de retorno
 	sw $s0,4($sp) # guarda valor dos registos
 	sw $s1,8($sp) # $s0, $s1 e $s2
 	sw $s2,12($sp) #
 	move $s0,$a0 # registo "callee-saved"
 	move $s1,$a0 # p1 = str
 	move $s2,$a0 # p2 = str
 	lb $t0, 0($s2)
while1: beq $t0, '\0', endw1 # while( *p2 != '\0' ) {
 	addiu $s2, $s2, 1 # p2++;
 	lb $t0, 0($s2)
 	j while1 # }
endw1:	subu $s2, $s2, 1 # p2--;

while2: bge $s1, $s2, endw2# while(p1 < p2) {
 	move $a0, $s1 #
 	move $a1, $s2 #
 	jal exchange # exchange(p1,p2)
	addiu $s1, $s1, 1
	subu $s2, $s2, 1
 	j while2 # }
 	
endw2: 	move $v0,$s0 # return str
 	lw $ra, 0($sp) # rep�e endere�o de retorno
 	lw $s0, 4($sp) # rep�e o valor dos registos
 	lw $s1, 8($sp) # $s0, $s1 e $s2
 	lw $s2, 12($sp) #
 	addiu $sp, $sp, 16 # liberta espa�o da stack
	jr $ra # termina a sub-rotina
	
exchange:
	lb $t0, 0($a0)
	lb $t1, 0($a1)
	sb $t1, 0($a0)
	sb $t0, 0($a1)
	jr $ra