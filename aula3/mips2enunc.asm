# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
# $t3 - flag print espaço
# $t4 . flag primeiro 1
 	.data
str1: 	.asciiz "Introduza um numero: \n"
str2: 	.asciiz "O valor em binário e: \n"
 	.eqv print_string,4
 	.eqv read_int, 5
 	.eqv print_char, 11
 	.text
 	.globl main

main: 	la $a0,str1
 	li $v0,print_string # (instrução virtual)
 	syscall # print_string(str1);
 	li $v0, read_int  # value=read_int();
	syscall
	or $t0, $0, $v0
 	la $a0, str2 # print_string("...");
 	li $v0, print_string
 	syscall
 	li $t2,0 # i = 0
 	li $t4, 0 #flag print
 	
for: 	bge $t2, 32,endfor # while(i < 32) {
	andi $t1,$t0,0x80000000 # (instrução virtual)
	srl $t1, $t1, 31
	addi $t1, $t1, 0x30
	bnez $t4, work
	bne $t1, 0x30, work # bit != 0
	j endif
	
	
work:	ori $t4, $0, 1
	rem $t3, $t2, 4
	bnez $t3, else_not_space
	ori $a0, $0, ' '
	li $v0, print_char
	syscall
	
else_not_space:
	or $a0, $0, $t1 # print_char(bit);
 	li $v0, print_char
 	syscall
	
endif:	sll $t0, $t0, 1
 	# value = value << 1;
 	addi $t2, $t2, 1
 	# i++;
 	j for # }
	 
endfor: #
 	jr $ra # fim do programa 