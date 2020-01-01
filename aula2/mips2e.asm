	.data
	.text
	.globl main
main: 	ori $t0,$0, 0x9 # substituir val_1 
 	srl $t1, $t0, 4
 	xor $t1, $t1, $t0
 	
 	srl $t0, $t1, 2
 	xor $t1, $t1, $t0
 	
 	srl $t0, $t1, 1
 	xor $t1, $t1, $t0
 	
 	or  $a0, $0, $t1
 	ori $v0, $0, 35
 	syscall
 	
 	jr $ra # fim do programa