	.data
	
	.text
	.globl main

main:	ori $v0, $0, 5
	syscall
	or $t0, $0, $v0
	ori $t2,$0,8 
	add $t1,$t0,$t0 
	add $t1,$t1,$t2 
	or $a0, $0, $t1
	ori $v0, $0, 1
	syscall
	
	ori $a0, $0, '\n'
	ori $v0, $0, 11
	syscall
	
	or $a0, $0, $t1
	ori $v0, $0, 34
	syscall
	
	ori $a0, $0, '\n'
	ori $v0, $0, 11
	syscall
	
	or $a0, $0, $t1
	ori $v0, $0, 36
	syscall
	
	jr $ra 