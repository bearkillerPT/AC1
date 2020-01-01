	.data
	.text
	.globl main
main: 	ori $t0,$0, 0xE543 # substituir val_1 
 	nor $t1, $0, $t0	
 	
 	or $a0, $0, $t1
 	ori $v0, $0, 34
 	syscall
 	
 	jr $ra # fim do programa