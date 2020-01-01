	.data # 0x10010000
 	.text # 0x00400000
 	.globl main
 main: 	addi $2,$0,0x1A
 	addi $3,$0,-7 
 	add $4,$2,$3 
 	sub $5,$2,$3 
 	and $6,$2,$3
 	or $7,$2,$3 
 	nor $8,$2,$3
 	xor $9,$2,$3 
 	slt $10,$2,$3
 	slti $11,$7,-2 
 	slti $12,$9,-25
 	nop
 	jr $ra # 
