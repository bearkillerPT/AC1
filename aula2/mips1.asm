	.data
	.text
	.globl main
main: 	ori $t0,$0, 0x5C1B # substituir val_1 e val_2 pelos
 	ori $t1,$0, 0xA3E4 # valores de entrada desejados
 	and $t2,$t0,$t1 # $t2 = $t0 & $t1 (and bit a bit)
 	or $t3, $t0, $t1 # $t3 = $t0 | $t1 (or bit a bit)
 	nor $t4, $t0, $t1
 	xor $t5, $t0, $t1	
 	
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
 	or $a0, $0, $t5
 	ori $v0, $0, 34
 	syscall
 	jr $ra # fim do programa