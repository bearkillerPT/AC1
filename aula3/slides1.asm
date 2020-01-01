# Mapa de registos:
# $t0 – soma
# $t1 – value
# $t2 - i
	.data
str1: .asciiz "Introduza um numero: "
str2: .asciiz "Valor ignorado\n"
str3: .asciiz "A soma dos positivos e: "
 	.eqv print_string,4
 	.eqv read_int,5 
	.text
	.globl main
main:   li $t0,0 # soma = 0;
	li $t1, 0 # i = 0;
for: blt $t2,5,endfor # while(i < 5) {
	# print_string("...");
	ori $v0, $0, 4
	or $a0, $0, str1
	syscall
	# value=read_int();
	ori $v0, $0, 5
	syscall
	or $t1, $0, $v0
	
	ble $t1,$0,else # if(value > 0)
	add $t0, $t0, $a0 # soma += value;
	j endif #
else: 
	ori $v0, $0, 4
	or $a0, $0, str2
	syscall
	j endif # else
	# print_string("...");
endif: addi $t2,$t2, 1 # i++;
	j for # }
endfor:
 	 # print_string("...");
 	ori $v0, $0, 4
	or $a0, $0, str3
	syscall
 	 # print_int10(soma);
 	ori $v0, $0, 4
	or $a0, $0, $t0
	syscall
 	jr $ra