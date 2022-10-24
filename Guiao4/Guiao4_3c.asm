 # Mapa de registos
 # $t0 - array
 # $t1 - i 	
 # $t2 - array +i
 # t4 - array[i]
 # $t3 - soma
 
 
 # PROGRAMA QUE SOMA ELEMENTOS DE ARRAY DE SIZE 4 ( versao indices)
 
 
 	.data
 	.eqv SIZE,4
 	.eqv print_int10,1
 
 array:	.word	9,9,1,1
 	.text
 	.globl main
 	
 	
 	
 main:	li	$t3,0		# soma = 0
 	
 	li	$t1,0		# i = 0

 while:	bgt	$t1,SIZE,endw	# while(i<= size)
 	la	$t0,array	# $t0 = array
 	sll	$t2,$t1,2	# $t2 = i * 4
 	addu	$t2,$t0,$t2	# array + i 
 	lw	$t4,0($t2)	# array[i] = $t4
 	
 	add	$t3,$t3,$t4	# soma = soma + array[i]
 	addi	$t1,$t1,1	# i++
 	
 	j	while
 
 endw:	move	$a0,$t3		#print soma
 	li	$v0,print_int10
 	syscall
 	
 	jr	$ra
 	
