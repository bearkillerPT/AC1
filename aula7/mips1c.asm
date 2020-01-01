# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1
# Sub-rotina terminal: não devem ser usados registos $sx
	.data
str:	.asciiz "0101"
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

atoi:	subu $sp, $sp, 4
	sw $ra, 0($sp)
	li $v0,0 # res = 0;
	li $t2, 1 # i = 0
	jal strrev
	move $s0, $v0
	li $v0,0
while: 	lb $t0, 0($s0) # while(*s >= ...)
 	blt $t0, '0', endwhile #
 	bgt $t0, '1', endwhile # {
	sub $t0, $t0, '0' # digit = *s – '0'
	mul $t0, $t0, $t2
 	addiu $s0, $s0, 1 # s++;
 	add $v0, $v0, $t0 # res =  res + digit;
 	sll $t2, $t2, 1
 	j while # }
endwhile:lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra # termina sub-rotina 

#FUNCAO STRING REVERSE	
strrev: subu $sp,$sp,16 # reserva espaço na stack
 	sw $ra,0($sp) # guarda endereço de retorno
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
 	lw $ra, 0($sp) # repõe endereço de retorno
 	lw $s0, 4($sp) # repõe o valor dos registos
 	lw $s1, 8($sp) # $s0, $s1 e $s2
 	lw $s2, 12($sp) #
 	addiu $sp, $sp, 16 # liberta espaço da stack
	jr $ra # termina a sub-rotina
	
exchange:
	lb $t0, 0($a0)
	lb $t1, 0($a1)
	sb $t1, 0($a0)
	sb $t0, 0($a1)
	jr $ra
