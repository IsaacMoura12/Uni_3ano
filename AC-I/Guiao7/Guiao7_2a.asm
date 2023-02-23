	.data
str:	.asciiz "ITED - orievA ed edadisrevinU"
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

#Sub-Rotina
#Mapa de Registos:
#str: $a0 -> $s0 (argumento é passado em $a0)
#p1:  $s1
#p2:  $s2
# Sub-rotina Intermedia

strrev: addiu	$sp,$sp,-16		#reserva espaço na stack
	sw	$ra,0($sp)		# guarda valor retorno
	
	sw	$s0,4($sp)		# guarda valor dos registos
	sw 	$s1,8($sp)		# $s0,$1 e $s2
	sw	$s2,12($sp)
	move	$s0,$a0			# registo callee-saved
	move	$s1,$a0			# p1 = str
	move	$s2,$a0			# p2 = str
	
	
while:	lb	$t0,0($s2)		# *p2
	beq	$t0,'\0',endw		# while(*p2 != '\0')
	addiu	$s2,$s2,1		# p2++
	j	while
endw:	sub	$s2,$s2,1		#p2--

while2:	bge	$s1,$s2,endw2		# while(p1<p2)
	move	$a0,$s1			# parametros entrada
	move	$a1,$s2			# para sub-rotina exchange
	jal	exchange		# chama sub-rotina
	addi	$s1,$s1,1		# p1++
	sub	$s2,$s2,1		# p2--
	j	while2
	
endw2:	move	$v0,$s0			# epilogo
	lw	$ra,0($sp)
	lw	$s0,4($sp)
	lw	$s1,8($sp)
	lw	$s2,12($sp)
	addiu	$sp,$sp,16
	jr $ra 	
#c1: $a0
#c2 : $a1
#Sub-rotina Terminal			
exchange:	lb	$t0,0($a0)
		lb	$t1,0($a1)
		sb	$t0,0($a1)
		sb	$t1,0($a0)
 		jr	$ra	
