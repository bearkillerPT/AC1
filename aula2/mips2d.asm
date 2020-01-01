	.data
	.text
	.globl main
main: 	ori $t0,$0, 0x9 # substituir val_1 
 	srl $t1, $t0, 1
 	xor  $a0, $t0, $t1
 	ori $v0, $0, 35
 	syscall
 	
 	jr $ra # fim do programa