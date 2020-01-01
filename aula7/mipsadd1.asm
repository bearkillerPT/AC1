	.data
dst:	.space 100
src:	.space 50
insert1:	.asciiz "Enter a string: "
inserta:.asciiz "Enter a string to insert: "
insertp:.asciiz "Enter the position: "
ostr:	.asciiz "Original String: "
mstr:	.asciiz "\nModified String: "
	.eqv read_string, 8
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_char, 11
	.text
	.globl main

main:	subu $sp, $sp, 4
	sw $ra, 0($sp)
	la $s0, dst
	la $s1, src
	la $a0, insert1
	li $v0, print_string
	syscall
	la $a0, dst
	li $a1, 50
	jal reads_string
	la $a0, inserta
	li $v0, print_string
	syscall
	la $a0, src
	li $a1, 50
	jal reads_string
	la $a0, insertp
	li $v0, print_string
	syscall
	li $v0, read_int
	syscall
	move $s2, $v0
	la $a0, ostr
	li $v0, print_string
	syscall
	la $a0, dst
	li $v0, print_string
	syscall
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal insert
	la $a0, mstr
	li $v0, print_string
	syscall
	la $a0, dst
	li $v0, print_string
	syscall
	li $a0, '\n'
	li $v0, print_char
	syscall
	lw $ra, 0($sp)
	addiu $sp, $sp 4
	li $v0, 0
	jr $ra
	
	
insert:	subu $sp, $sp, 32
	sw $ra, 0($sp) 
	sw $s0, 4($sp) # S0 -> *dst
	sw $s1, 8($sp) # S1 -> *src
	sw $s2, 12($sp) # S2 -> dst_len
	sw $s3, 16($sp) # S3 -> src_len
	sw $s4, 20($sp)	# S4 -> i
	sw $s5, 24($sp) # S5 -> *p
	sw $s6, 28($sp) # S6 -> pos
	move $s6, $a2
	move $s0, $a0
	move $s1, $a1
	jal strlen
	move $s2, $v0 # S2 -> dst_len
	move $a0, $s1
	jal strlen
	move $s3, $v0 # S3 -> src_len
	move $s4, $s2 # i = dst_len
for1:	blt $s4, $s6, endfor1
	addu $s5, $s0, $s4
	lb $t1, 0($s5)
	addu $s5, $s5, $s3
	sb $t1, 0($s5)
	sub $s4, $s4, 1
	j for1
endfor1:li $s4, 0 # i = 0
for2:	bge $s4, $s3, endfor2
	addu $s5, $s1, $s4
	lb $t1, 0($s5)
	addu $s5, $s0, $s4
	addu $s5, $s5, $s6
	sb $t1, 0($s5)
	addi $s4, $s4, 1
	j for2
endfor2:lw $ra, 0($sp) 
	lw $s0, 4($sp) # S0 -> *dst
	lw $s1, 8($sp) # S1 -> *src
	lw $s2, 12($sp) # S2 -> dst_len
	lw $s3, 16($sp) # S3 -> src_len
	lw $s4, 20($sp)	# S4 -> i
	lw $s5, 24($sp) # S5 -> *p
	lw $s6, 28($sp) # S6 -> pos
	addiu $sp, $sp, 32
	move $v0, $s0
	jr $ra


reads_string:
	subu $sp, $sp, 12
	sw $ra, 0($sp)
	sw $s0, 4($sp) #str
	sw $s1, 8($sp) #str_ len
	move $s0, $a0
	move $s1, $a1
	li $v0, read_string
	syscall
	jal strlen
	move $s1, $v0
	sub $s1, $s1, 1
	sll $s1, $s1, 2
	addu $s0, $s0, $s1
	lw $t0, 0($s0)
	bne $t0, 0x0A, els
	sw $0, 0($s0)
els:	lw $ra, 0($sp)
	lw $s0, 4($sp) 
	lw $s1, 8($sp) 
	addiu $sp, $sp, 12
	jr $ra

strlen: li $t1,0 # len = 0;
while: 	lb $t0, 0($a0) # while(*s++ != '\0')
 	addiu $a0,$a0,1 #
 	beq $t0,'\0',endw # {
 	addi $t1, $t1, 1 # len++;
 	j while # }
endw: 	move $v0,$t1 # return len;
 	jr $ra # 
