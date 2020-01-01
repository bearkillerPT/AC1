#2b

	.data
 	.text
 	.globl main
main: 	li $t0,0x862A5C1B # instrução virtual (decomposta
 	# em duas instruções nativas)
 	sll $t2,$t0,4 #
 	srl $t3,$t0,4 #
 	sra $t4,$t0,4 #
 	
 	or $a0, $0, $t2
 	ori $v0, $0, 34
 	syscall
 	ori $a0, $0, '\n'
	ori $v0, $0, 11
	syscall
	
	or $a0, $0, $t3
 	ori $v0, $0, 34
 	syscall
 	ori $a0, $0, '\n'
	ori $v0, $0, 11
	syscall
	
	or $a0, $0, $t4
 	ori $v0, $0, 34
 	syscall
 	ori $a0, $0, '\n'
	ori $v0, $0, 11
	syscall
 	
 	jr $ra # fim do programa