	.data
	str1: .asciiz "Introduza 2 numeros"
	str2: .asciiz "A soma dos 2 numeros e:"
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv read_int, 5
	.text
	.globl main
main:	
	#print_string("Introduza 2 numeros "); 
	la $a0, str1
	ori $v0, $0, print_string
	syscall
	ori $a0, $0, '\n'
	ori $v0, $0, 11
	syscall
	
	#a = read_int(); 
	ori $v0, $0, read_int
	syscall
	or $t0, $0, $v0
	
	#b = read_int(); 
	ori $v0, $0, read_int
	syscall
	or $t1, $0, $v0
	ori $a0, $0, '\n'
	ori $v0, $0, 11
	syscall
	
	#print_string("A soma dos dois numeros e': "); 
	la $a0, str2
	ori $v0, $0, print_string
	syscall
	
	add $t2, $t0, $t1
	or $a0, $0, $t2
	ori $v0, $0, print_int10
	syscall
	jr $ra