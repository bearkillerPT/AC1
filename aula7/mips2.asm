	.data
num:	.space 20
insertnum:.asciiz "Insira um numero!\n"
base2:	.asciiz "Base 2: "
base8:	.asciiz "\nBase 8: "
base16:	.asciiz "\nBase 16: "
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_char, 11
	.text
	.globl main

main:	addi $sp, $sp, -4
	sw $ra, 0($sp)
donot0:	la $a0, insertnum
	li $v0, print_string
	syscall
	li $v0, read_int
	syscall
	move $s0, $v0  #s0 = val
	la $a0, base2
	li $v0, print_string
	syscall
	move $a0, $s0
	li $a1, 2
	la $a2, num
	jal itoa
	move $a0, $v0
	li $v0, print_string
	syscall
	la $a0, base8
	li $v0, print_string
	syscall
	move $a0, $s0
	li $a1, 8
	la $a2, num
	jal itoa
	move $a0, $v0
	li $v0, print_string
	syscall
	la $a0, base16
	li $v0, print_string
	syscall
	move $a0, $s0
	li $a1, 16
	la $a2, num
	jal itoa
	move $a0, $v0
	li $v0, print_string
	syscall
	li $a0, '\n'
	li $v0, print_char
	syscall
	bnez $s0, donot0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	li $v0, 0
	jr $ra






# Mapa de registos
# n: $a0 -> $s0
# b: $a1 -> $s1
# s: $a2 -> $s2
# p: $s3
# digit: $t0
# Sub-rotina intermédia
itoa: 	addi $sp, $sp, -20# reserva espaço na stack
 	sw $ra, 0($sp)    # guarda registos $sx e $ra
 	sw $s0, 4($sp) 
 	sw $s1, 8($sp)
 	sw $s2, 12($sp)
 	sw $s3, 16($sp)
 	move $s0, $a0 # copia n, b e s para registos
 	move $s1, $a1
 	move $s2, $a2 # "callee-saved"
 	move $s3,$a2 # p = s;
do: 	# do {
 	rem $a0, $s0, $s1
 	div $s0, $s0, $s1
 	jal toascii
 	sb $v0, 0($s3)
 	addiu $s3, $s3, 1
 	bgtz $s0, do # } while(n > 0);
 	sb $0,0($s3) # *p = 0;
 	move $a0, $s2
 	jal strrev # strrev( s );
 	 # return s;
 	 
 	lw $ra, 0($sp)   # repõe registos $sx e $ra
 	lw $s0, 4($sp) 
 	lw $s1, 8($sp)
 	lw $s2, 12($sp)
 	lw $s3, 16($sp)
 	addiu $sp, $sp, 20# liberta espaço na stack
 	jr $ra # 

toascii:addi $v0, $a0, '0'
	ble $v0, '9', elseas
	addi $v0, $v0, 7
elseas:	jr $ra



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
