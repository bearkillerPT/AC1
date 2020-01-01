# Mapa de registos
# p: $t0
# pultimo:$t1
# *p $t2
# soma: $t3
# i : $t4
# str+4*i - $t5
 	.data
array:	.word 7692, 23, 5, 234
 	.eqv print_int10, 1
 	.eqv SIZE,4
 	.text
 	.globl main
 	
main: 	li $t3, 0 # soma = 0;
 	li $t4,SIZE #
 	sub $t4, $t4, 1
 	sll $t4,$t4,2 # #$t5= str+4*i
 	la $t0, array # p = array;
 	addu $t1,$t0,$t4 # pultimo = array + SIZE - 1;
 	li $t4, 0 # t4 passa a i!
while: # while(p <= pultimo)
 	bgtu $t5, $t1,endw # {
 	sll $t5,$t4,2 # #$t5= str+4*i
 	add $t5, $t5, $t0
 	lw $t2,0($t5) # $t2 = *p;
 	add $t3, $t3, $t2 # soma = soma + (*p);
 	addiu $t4,$t4, 1 # i++;
 	j while# }
 	
endw: 	move $a0, $t3 # print_int10(soma);
	li $v0, print_int10
	syscall
	jr $ra # termina o programa 
