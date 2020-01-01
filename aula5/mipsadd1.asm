# Mapa de registos
# ...
# houve_troca: $t4
# i: $t5
# lista: $t6
# lista + i: $t7
#SIZE-1: $t8
 	.data
 	.eqv FALSE,0
 	.eqv TRUE,1
 	.eqv read_int, 5
 	.eqv print_int10, 1
 	.eqv print_string, 4 	
 	.eqv print_char, 11
 	.eqv SIZE, 10 
lista:	.space 40 # SIZE * 4
str1: 	.asciiz "\nIntroduza um numero: "
str2: 	.asciiz "; "
str3: 	.asciiz "Conteudo do array:"
 	.text
	.globl main
main: 	# código para leitura de valores
	li $t0,0 # i = 0;
while1: bge $t0, SIZE, endw1 # while(i < SIZE) {
 	# print_string(...);
 	la $a0, str1
 	li $v0, print_string
 	syscall
 	li $v0,read_int
 	syscall # $v0 = read_int();
 	la $t1, lista # $t1 = lista (ou &lista[0])
 	sll $t2,$t0, 2 #
 	addu $t2, $t2, $t1 # $t2 = &lista[i]
 	sw $v0, 0($t2) # lista[i] = read_int();
 	addi $t0, $t0, 1 # i++
 	j while1 # }
 	
endw1:
 	la $t6,lista #
 	li $t1, 40
 	add $t1, $t1, $t6
 	or $t4, $0, $0 #i = &lista[0]
 	add $t4, $t4, $t6
 	addi $t5, $t4, 4 #j = i++
 	or $t2, $0, $0  #aux = 0
for1:	bge $t4, $t1, endfor1	 #for(i=&lista[0]; i < &lista[SIZE]; i++)

for2:	bge $t5, $t1, endfor2	#for(j = i++; j < &lista[SIZE]; j++)		 			 #{
	lw $t8, 0($t4)
	lw $t9, 0($t5)
	ble $t8, $t9, endif	 #if(lista[i] > lista[j]){
	or $t2, $0, $t8		 #aux = lista[i];
	sw $t9, 0($t4)		 #lista[i] = lista[j];
	sw $t2, 0($t5)		 #lista[j] = aux;
endif:	
	addi $t5, $t5, 4 #j++			 #}
	j for2		 #}
endfor2:
	addi $t4, $t4, 4 #i++	
	addi $t5, $t4, 4		#j=i+1 #}
	j for1
endfor1:
	# codigo de impressao do
 	# conteudo do array
 	la $a0, str3
 	li $v0, print_string
 	syscall
 	li $t5, 0
 	la $t6, lista
 while2:
 	
 	sll $t2, $t5, 2
 	addu $t2, $t2, $t6
 	lw $t8, 0($t2)
 	or $a0, $0, $t8
 	li $v0, print_int10
 	syscall
 	la $a0, str2
 	li $v0, print_string
 	syscall
 	ori $a0, $0, '\n'
 	li $v0, print_char
 	syscall
 	addi $t5, $t5, 1
 	blt $t5, SIZE, while2 
 	
 	jr $ra 

#
#OPTIMIZAÇOES:
#Não hánecessidade de ter um int aux para fazer a troca dos valores!
#
