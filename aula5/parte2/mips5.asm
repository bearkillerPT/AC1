# Mapa de registos
#i : $t0
#str[i] : $t1
#&str[i] : $t2
#&strin mais longa : $t3
#size strin mais longa : $t4
#sizestr[i] : $t5
#numMinusculas : $t6
#numMaiusculas : $t7

 	.data
str1: 	.asciiz "Nr. de parametros: "
str2: 	.asciiz "\nP"
str3: 	.asciiz ": "
str4:	.asciiz " caracteres\n"
str5:	.asciiz " minusculas\n"
str6:	.asciiz " maiusculas\n"
str7:	.asciiz "String mais longa:\n"
 	.eqv print_string,4
 	.eqv print_char, 11
 	.eqv print_int10,1
 	.text
 	.globl main
main: 	li $t0, 0 # i = 0
	or $s0, $a0, $0 # $s0 = argc
	or $s1, $a1, $0 # $s1 = &argv
	li $t4, 0
	la $a0, str1
	li $v0, print_string
	syscall
	or $a0, $s0, $0
	li $v0, print_int10
	syscall
for:	bge $t0, $s0, endfor
	li $t5, 0
	li $t6, 0 
	li $t7, 0
	la $a0, str2 
	li $v0, print_string
	syscall
	or $a0, $t0, $0
	li $v0, print_int10
	syscall
	la $a0, str3
	li $v0, print_string
	syscall
	ori $a0, $0, '\n'
	li $v0, print_char
	syscall
	sll $t1, $t0, 2
	addu $t2, $t1, $s1
	lw $t2, 0($t2)
	or $s2, $0, $t2
	lb $t1, 0($t2)
	li $t5, 0
charC:	beq $t1, '\0', endCharC
	addi $t5, $t5, 1
	blt $t1, 65, endif
	bgt $t1, 90, checkMin
	addi $t7, $t7, 1
	j endif
checkMin:
	blt $t1, 97, endif
	bgt $t1, 122, endif
	addi $t6, $t6, 1
endif:	
	addiu $t2, $t2, 1
	lb $t1, 0($t2)
	j charC

endCharC:
	or $a0, $t5, $0
	li $v0, print_int10
	syscall
	la $a0, str4
	li $v0, print_string
	syscall
	
	or $a0, $t6, $0
	li $v0, print_int10
	syscall
	la $a0, str5
	li $v0, print_string
	syscall
	or $a0, $t7, $0
	li $v0, print_int10
	syscall
	la $a0, str6
	li $v0, print_string
	syscall
	ble $t5, $t4, elseMax 
	or $t4, $t5, $0
	or $t3, $0, $s2
	
elseMax:
	addi $t0, $t0, 1
	j for
endfor:	
	la $a0, str7
	li $v0, print_string
	syscall
	or $a0, $0, $t3
	li $v0, print_string
	syscall
	li $v0, 0
	jr $ra
