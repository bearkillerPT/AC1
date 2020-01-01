# Mapa de registos
# p: $t0
# *p $t1


 	.data
strIn:	.space 20
strOut:	.asciiz "Introduza uma string:\n"
 	.eqv print_string, 4
 	.eqv read_string, 8
 	.eqv SIZE, 20
 	.text
 	.globl main
 	
main: 	la $a0, strOut
	li $v0, print_string
	syscall
	
	la $a0, strIn
	li $a1, SIZE
	li $v0, read_string
	syscall
	
	la $t1, strIn
	
convWhile:	
	lb $t0, 0($t1)
	beqz $t0, endConvW
	blt $t0, 97, else
	bgt $t0, 122, else
	sub $t0, $t0, 0x20
	sb $t0, 0($t1)
	j endif
	
else:	blt $t0, 65, endif
	bgt $t0, 90, endif
	addi $t0, $t0, 0x20
	sb $t0, 0($t1)
	
endif:	addi $t1, $t1, 1
	j convWhile
	
endConvW:
	la $a0, strIn
	li $v0, print_string
	syscall
	jr $ra
		