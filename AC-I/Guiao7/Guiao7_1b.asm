	.data
str:	.asciiz "Arquitetura de Computadores I"
	.eqv print_int10,1
	.text
	.globl main
	
	
main:	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str
	jal	strlen
	move	$t0,$v0
	li	$v0,print_int10
	move	$a0,$t0
	syscall
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	li	$v0,0
	jr	$ra

#Sub-Rotina
strlen: li $t1,0 			# len = 0; 

while: 	lb $t0,0($a0)			# while(*s++ != '\0') 
 	addiu $a0,$a0,1			# 
 	beq $t0,'\0',endw 		# { 
 	addi $t1,$t1,1			# len++; 
 	j while				# } 
 
endw:	move $v0,$t1			# return len; 
 	jr $ra 		
 	
 					
 							
 