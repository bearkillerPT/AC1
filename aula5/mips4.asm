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
 	li $t5, SIZE #SIZE-1
 	sub $t5, $t5, 1
 	sll $t5, $t5, 2
 	addu $t5, $t5, $t6 # listaultimo
 	
do: 	# do {
 	li $t4,FALSE # houve_troca = FALSE;
wwhile: bgt $t6, $t5, endww # while(&lista++++ < listaultimo){
 	lw $t8,0($t6) # $t8 = lista[i]
 	lw $t9,4($t6) # $t9 = lista[i+1]
if: 	bleu $t8, $t9, endif # if(lista[i] > lista[i+1]){
 	sw $t8,4($t6) # lista[i+1] = $t8
 	sw $t9,0($t6) # lista[i] = $t9
 	li $t4,TRUE #}
endif: 	addi $t6,$t6,4 # $t6 += 4; *p++
	j wwhile
endww:
 	# }
 	beq $t4, TRUE, do# } while(houve_troca == TRUE);
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