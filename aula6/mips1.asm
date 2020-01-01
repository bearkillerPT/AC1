.data
staticStr:.asciiz "I serodatupmoC ed arutetiuqrA"
	.eqv print_string,4
 	.eqv print_char, 11
 	.eqv print_int10,1
	.text
	.globl main


main:	la $a0, staticStr #$a0 = &str
	or $s0, $ra, $0
	jal strlen
	
	or $a0, $v0, $0
	li $v0, print_int10
	syscall
	
	or $ra, $s0, $0
	li $v0, 0 #$v0 = 0 (return code)
	jr $ra
	


strlen: li $t1,0 # len = 0;
while: 	lb $t0, 0($a0) # while(*s++ != '\0')
 	addiu $a0,$a0,1 #
 	beq $t0,'\0',endw # {
 	addi $t1, $t1, 1 # len++;
 	j while # }
endw: 	move $v0,$t1 # return len;
 	jr $ra # 

