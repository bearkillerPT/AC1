#Mapa de variaveis
# $s0 = &arr 
# $s1 = &auxarr
# $s2 = i
# $s3 = dupCounter 
# $s4 = arr[i]
#	
	.data
arr:	.space 40
auxarr:	.space 40
arr0:	.asciiz "array["
arr1:	.asciiz "] = "
dup:	.asciiz "*, "
num:	.asciiz ", "
repeat:	.asciiz "\n# repetidos: "
	.eqv SIZE, 10
	.eqv print_char, 11
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv read_int, 5
	.text
	.globl main
	
main:	la $s0, arr
	la $s1, auxarr
	li $s2, 0
	li $s3, 0
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	
readfor:bge $s2, SIZE, endread
	la $a0, arr0
	li $v0, print_string
	syscall
	move $a0, $s2
	li $v0, print_int10
	syscall
	la $a0, arr1
	li $v0, print_string
	syscall
	sll $s4, $s2, 2
	addu $s4, $s4, $s0
	li $v0, read_int
	syscall
	sw $v0, 0($s4)
	addi $s2, $s2, 1
	j readfor
endread:
	move $a0, $s0
	move $a1, $s1
	li $a2, SIZE
	jal find_dup
	li $s2, 0
foraux:	bge $s2, SIZE, endaux
	sll $s4, $s2, 2
	addu $s4, $s4, $s1
	lw $s4, 0($s4)
	
	blt $s4, 2, nodup
	la $a0, dup
	li $v0, print_string
	syscall
	addi $s3, $s3, 1
	addi $s2, $s2, 1
	j foraux

nodup:	sll $a0, $s2, 2
	addu $a0, $a0, $s0
	lw $a0, 0($a0)
	li $v0, print_int10
	syscall
	la $a0, num
	li $v0, print_string
	syscall	
	addi $s2, $s2, 1
	j foraux

endaux:	la $a0, repeat
	li $v0, print_string
	syscall
	move $a0, $s3
	li $v0, print_int10
	syscall
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	li $v0, 0
	jr $ra
	
find_dup:
# $t0 - i 
# $t1 - j
# $t2 - token
# $t3 - arr[i]
# $t4 - arr[j]
	subu $sp, $sp, 4
	sw $ra, 0($sp)
	li $t0, 0
fori:	bge $t0, $a2, endfori
	sll $t3, $t0, 2
	addu $t3, $t3, $a1
	sw $0, 0($t3)
	li $t1, 0
	li $t2, 1
forj:	bge $t1, $a2, endforj
	sll $t3, $t0, 2
	addu $t3, $t3, $a0
	sll $t4, $t1, 2
	addu $t4, $t4, $a0
	lw $t3, 0($t3)
	lw $t4, 0($t4)
	bne $t3, $t4, noteq
	sll $t4, $t1, 2
	addu $t4, $t4, $a1
	sw $t2, 0($t4)
	addi $t2, $t2, 1
noteq:	addi $t1, $t1, 1
	j forj

endforj:addi $t0, $t0, 1
	j fori

endfori:lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra	
