		.data
str:		.asciiz "ITED - orievA ed edadisrevinU"
		.eqv print_string,4
		.text
		.globl main
		
main:	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str
	jal	strrev
	move	$t0,$v0
	
	li	$v0,print_string
	move	$a0,$t0
	syscall
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	
	li	$v0,0
	jr	$ra
	


#Sub-rotina intermedia
# recebe em $a0 o ponteiro para str
# $s0 - $a0
# $s1 - p1	
# $s2 - p2
#
strrev:	addiu	$sp,$sp,-16		#eserva espaço no stack
	sw	$ra,0($sp)		# guarda valor dos registos
	sw	$s0,4($sp)		# guarda endereço retorno
	sw	$s1,8($sp)
	sw	$s2,12($sp)
	move	$s0,$a0			
	move	$s1,$a1
	move	$s2,$a2
	
while:	lb	$t0,0($s2)		# $t0 = str
	beq	$t0,'\0',endw		# while(*p2 != '\0')
	addiu	$s2,$s2,1		# p2++
	j	while
endw:	sub	$s2,$s2,1		#p2--
	
while2:	bge	$s1,$s2,endw2
	move	$a0,$s1
	move	$a1,$s2
	jal	exchange
	addi	$s1,$s1,1
	sub	$s2,$s2,1
	j	while2
	
endw2:	move	$v0,$s0			# return str
	lw	$ra,0($sp)
	lw	$s0,4($sp)
	lw	$s1,8($sp)
	lw	$s2,12($sp)
	addiu	$sp,$sp,16
	jr	$ra
	

# sub rotina terminal
# recebe em $a0 e $a1 ponteiros para caracter
# inverte caracteres
# nao devolve nada
exchange:	lb	$t0,0($a0)
		lb	$t1,0($a1)
		sb	$t1,0($a0)
		sb	$t0,0($a1)
		jr	$ra
		
