 # Mapa de registos
 # $t0 - p
 # $t1 - penultimo
 # $t2 - *p
 # $t3 - soma
 
 # PROGRAMA QUE SOMA ELEMENTOS DE ARRAY DE SIZE 4 ( versao ponteiros)
 
 
 	.data
 	.eqv SIZE,4
 	.eqv print_int10,1
 	.eqv read_int,5
 	
 	
 	
 array:	.word	3,3,3,3
 	.text
 	.globl main
 	
 	
 	
 main:	li	$t3,0		# soma = 0
 	li	$t4,SIZE	# $t4 = 4
 	sub	$t4,$t4,1	# $t4 = 3
 	sll	$t4,$t4,2	# $t4 * 4
 	la	$t0,array
 	addu	$t1,$t0,$t4	# penultimo = array + SIZE -1
 	
 while:	bgt	$t0,$t1,endw	# while(p <= penultimo)
 	lw	$t2,0($t0)	# $t2 = *p
 	add	$t3,$t3,$t2	# soma = soma + (*p)
 	addiu	$t0,$t0,4	# p++
 	
 	j	while
 
 endw:	move	$a0,$t3		#print soma
 	li	$v0,print_int10
 	syscall
 	
 	jr	$ra
 	
