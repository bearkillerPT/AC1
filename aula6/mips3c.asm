# Mapa de registos:
# str: $a0 -> $s0 (argumento é passado em $a0)
# p1: $s1 (registo callee-saved)
# p2: $s2 (registo callee-saved)
#
	.data
dst:	.space 30
src:	.asciiz "I serodatupmoC ed arutetiuqrA"
toolong:.asciiz "String too long: "
	.eqv print_string,4
 	.eqv print_char, 11
 	.eqv print_int10,1
 	.eqv maxSize, 30
	.text
	.globl main

main:	la $a0, src
	subu $sp, $sp, 4 # reserva espaço na stack
	sw $ra,0($sp) #guarda endereço de retorno
	jal strlen
	move $s0, $v0
	bgt $s0, maxSize, toobig
	la $a0, dst
	la $a1, src
	jal strcpy
	move $a0, $v0
	li $v0, print_string
	syscall
	li $a0, '\n'
	li $v0, print_char
	syscall
	la $a0, dst
	jal strrev
	move $a0, $v0
	li $v0, print_string
	syscall
	li $v0, 0 # return 0
	j endMain
	
toobig:	la $a0, toolong
	li $v0, print_string
	syscall
	move $a0, $s0
	li $v0, print_int10
	syscall
	li $v0, -1
	
endMain:lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra

#FUNCAO STRING COPY
strcpy:	subu $sp, $sp, 12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	move $a0, $a1
	jal strlen #strlen(*src)
	move $t3, $v0 #t3 = strlen(*src)
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addiu $sp, $sp, 12
	move $t1, $a0 #t1 = &dst
	move $t2, $a1 #t2 = &src
	addu $t3, $t2, $t3 #&src end
dowhile:
	lb $t0, 0($t2) #t3 = *src	
	sb $t0, 0($t1)  #*dst = t3	
	addiu $t1, $t1, 1
	addiu $t2, $t2, 1
	blt $t2, $t3, dowhile
	
	move $v0, $a0
	jr $ra
	
#FUNCAO STRING LENGHT	
strlen: li $t1,0 # len = 0;
while: 	lb $t0, 0($a0) # while(*s++ != '\0')
 	addiu $a0,$a0,1 #
 	beq $t0,'\0',endw # {
 	addi $t1, $t1, 1 # len++;
 	j while # }
endw: 	move $v0,$t1 # return len;
 	jr $ra # 

	
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
