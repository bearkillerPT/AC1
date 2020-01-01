	.data
quociente:.asciiz "Quociente: "
resto:	.asciiz "Resto:	"
	.eqv print_char, 11
	.eqv print_string, 4
	.eqv print_int10, 1
	.text
	.globl main

main:	subu $sp, $sp, 8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	li $a0, 0x8001
	li $a1,	3
	jal divc
	move $s0, $v0
	la $a0, quociente
	li $v0, print_string
	syscall
	andi $a0, $s0, 0x0000FFFF
	li $v0, print_int10
	syscall
	li $a0, '\n'
	li $v0, print_char
	syscall
	la $a0, resto
	li $v0, print_string
	syscall
	andi $a0, $s0, 0xFFFF0000
	srl $a0, $a0, 16
	li $v0, print_int10
	syscall
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	li $v0, 0
	jr $ra


divc:	#unsigned int div(unsigned int dividendo, unsigned int divisor) {
	li $t0, 0 #t0 -> i 
	li $t1, 0 #t1 -> bit
	li $t2, 0 #t2 -> quociente
	li $t3, 0 #t3 -> resto
	sll $a1, $a1, 16 #divisor = divisor << 16; 
	andi $a0, $a0, 0xFFFF #dividendo = (dividendo & 0xFFFF)
	sll $a0, $a0, 1	      #dividendo = """""""""""""""""""" << 1
for:	bge $t0, 16, endfor   #for(; i < 16; ) {
	li $t1, 0		#bit = 0
	blt $a0, $a1, cont 	#if(dividendo >= divisor) 
	sub $a0, $a0, $a1	  #dividendo = dividendo - divisor; 
	li $t1, 1		  #bit = 1
cont:	sll $a0, $a0, 1		#dividendo = (dividendo << 1);	
	or $a0, $a0, $t1	#dividendo = ***************** | bit; 
	addi $t0, $t0, 1	#i++;
	j for		      #}
endfor:	srl $t3, $a0, 1		#resto = (dividendo >> 1)
	andi $t3, $t3, 0xFFFF0000#resto =**************** & 0xFFFF0000; 
	andi $t2, $a0, 0x0000FFFF#quociente = dividendo & 0xFFFF; 
	move $v0, $t3	#toReturn = resto(16 bits mais significativos)
	or $v0, $v0, $t2#toReturn = return | quociente (16 LSB)
	jr $ra		#return toReturn = (resto | quociente); 
	
