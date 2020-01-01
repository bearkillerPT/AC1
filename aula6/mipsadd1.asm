#Mapa
#$s0 = &arr
#$s1 = arr.length
#$s2 = i
#$s3 = &arr[i]
#$s4 = val
#$s5 = pos

	.data
arr:	.space 50
	.eqv print_string,4
 	.eqv print_char, 11
 	.eqv print_int10,1
 	.eqv read_int, 5
 	.eqv SIZE, 50
bt_int:	.asciiz ", "
arrs:	.asciiz "Size of array : \n"
arr0:	.asciiz "array["
arr1:	.asciiz "] = "
rval:	.asciiz "Enter the value to be inserted: \n"
rpos:	.asciiz "Enter the position: \n"
oriarr:	.asciiz "\nOriginal array: \n"
modarr:	.asciiz "\nModified array: \n"
	.text
	.globl main

main:	subu $sp, $sp, 4
	sw $ra, 0($sp)
	la $s0, arr
	la $a0, arrs
	li $v0, print_string
	syscall
	li $v0, read_int
	syscall
	move $s1, $v0
	li, $a0, '\n'
	li $v0, print_char
	syscall
	li $s2, 0
	la $s3, arr
for:	bge $s2, $s1, endfor #for(i=0; i < array_size; i++)
	la $a0, arr0
	li $v0, print_string
	syscall 		#print_string("array["); 
	move $a0, $s2
	li $v0, print_int10
	syscall			#print_int10(i); 
	la $a0, arr1
	li $v0, print_string
	syscall			#print_string("] = "); 
	li $v0, read_int
	syscall
	sw $v0, 0($s3)		#array[i] = read_int(); 
	li, $a0, '\n'
	li $v0, print_char
	syscall
	addiu $s3, $s3, 4
	addi $s2, $s2, 1
	j for
endfor:
	la $a0, rval	#print_string("Enter the value to be inserted: "); 
	li $v0, print_string
	syscall
	li $v0, read_int
	syscall	
	move $s4, $v0	#insert_value = read_int();
	li, $a0, '\n'
	li $v0, print_char
	syscall	
	la $a0, rpos
	li $v0, print_string
	syscall		#print_string("Enter the position: "); 
	li $v0, read_int
	syscall	
	move $s5, $v0	#insert_pos = read_int();	
	li, $a0, '\n'
	li $v0, print_char
	syscall
	la $a0, oriarr
	li $v0, print_string
	syscall
	la $a0, arr
	move $a1, $s1
	jal print_array
	move $a0, $s0
	move $a1, $s4
	move $a2, $s5
	move $a3, $s1
	jal insert
	la $a0, modarr
	li $v0 print_string
	syscall
	la $a0, arr
	move $a1, $s1
	addi $a1, $a1, 1
	jal print_array
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	li $v0, 0
	jr $ra 

print_array:
	move $t0, $a0	   # t0 = a
	move $t1, $a1
	sll $t1, $t1, 2
	addu $t1, $t1, $a0 #int *p = a + n
	
printfor:
	bge $t0, $t1, endprint
	lw $t2, 0($t0)
	move $a0, $t2
	li $v0, print_int10
	syscall
	la $a0, bt_int
	li $v0, print_string
	syscall
	addiu $t0, $t0, 4
	j printfor
endprint:
	li $a0, '\n'
	li $v0, print_char
	syscall
	jr $ra

insert: move $t0, $a0
	move $t1, $a3 # *pultimo
	sll $t1, $t1, 2
	addu $t1, $t1, $t0 # *pultimo
	move $t3, $a3 #i = size
	move $t4, $a2 #t4 = pos
	addi $t3, $t3, 1
	ble $a2, $a3, ifor #if pos > SIZE
	li $v0, 1	
	jr $ra
	
ifor:	blt $t3, $t4, iendfor
	lw $t2, 0($t1)
	sw $t2, 4($t1)
	subu $t1, $t1, 4 #i--
	sub $t3, $t3, 1
	j ifor
iendfor:addiu $t1, $t1, 4
	move $t2, $a1
	sw $t2, 0($t1)
	li $v0, 0
	jr $ra	