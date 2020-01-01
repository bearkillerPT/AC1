# Mapa de registos:
# str: $a0 -> $s0 (argumento é passado em $a0)
# p1: $s1 (registo callee-saved)
# p2: $s2 (registo callee-saved)
#
	.data
dst:	.space 30
src1:	.asciiz "Arquitetura de "
src2:	.asciiz "Computadores I"
toolong:.asciiz "String too long: "
	.eqv print_string,4
 	.eqv print_char, 11
 	.eqv print_int10,1
 	.eqv maxSize, 15
	.text
	.globl main

main:	la $a0, src1
	subu $sp, $sp, 4 # reserva espaço na stack
	sw $ra,0($sp) #guarda endereço de retorno
	jal strlen
	move $s0, $v0
	bgt $s0, maxSize, toobig
	la $a0, dst
	la $a1, src1
	jal strcpy	
	la $a0, dst
	li $v0, print_string
	syscall
	li $a0, '\n'
	li $v0, print_char
	syscall
	la $a0, dst
	la $a1, src2
	jal strcat
	move $a0, $v0
	li $v0, print_string
	syscall
	li $a0, '\n'
	li $v0, print_char
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

strcat:	subu $sp, $sp, 8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	lb $s0, 0($a0)
whils:	beq $s0, '\0', endwhils
	addiu $a0, $a0, 1
	lb $s0, 0($a0)
	j whils
endwhils:
	jal strcpy
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addiu $sp, $sp, 8
	move $v0, $a0
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

	

