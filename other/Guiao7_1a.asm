		.data
		
str:		.asciiz "Arquitetura de Computadores"
		.eqv print_int10,1
		.text
		.globl main
		
		
main:	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str
	jal	strlen
	move	$t1,$v0
	
	li	$v0,print_int10
	move	$a0,$t1
	syscall
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	
	li	$v0,0
	jr	$ra





# Sub-rotina Terminal
# recebe string em $a0
# retorna $v0
# $t0 - len

strlen:	li	$t0,0
	
	
while:	lb	$t1,0($a0)
	addiu	$a0,$a0,1
	beq	$t1,'\0',endw		# while(*s++ != '\0')
	addi	$t0,$t0,1		#LEN++
	j	while
endw:	move	$v0,$t0			# return len
	jr	$ra
	
	
