		.data
str1:		.asciiz "I serodatupmoC ed arutetiuqrA"
str2:		.space	30
str3:		.asciiz "String too long"
str4:		.asciiz "\n"
		.eqv	STR_MAX_SIZE,30
		.eqv	print_string,4
		.eqv	print_int10,1
		.text
		.globl main
		
# exit_value - $t4		
main:	addiu	$sp,$sp,-4		# epilogo ( guardar $ra)
	sw	$ra,0($sp)
	la	$a0,str1
	jal	strlen
	

if:	bgt	$v0,STR_MAX_SIZE,else	# if (strlen(str1) <=STR_MAX)
	la	$a0,str2
	la	$a1,str1
	jal	strcpy
	
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	la	$a0,str4
	li	$v0,print_string
	syscall
	
	la	$a0,str2
	jal	strrev
	
	move	$a0,$v0
	li	$v0,print_string
	syscall	
	
	li	$t4,0		#exit_value = 0
	j	endif
	
else:	la	$a0,str3
	li	$v0,print_string
	syscall
	la	$a0,str1
	jal	strlen
	
	move	$a0,$v0
	li	$v0,print_int10
	syscall
	li	$t4,-1		#exit_value = -1

endif:	move	$v0,$t4
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	jr	$ra






# sub rotina terminal
# $a0 - str dst (ponteiro)
# $a1 - src dst (ponteiro)

strcpy:	li	$t2,0		#i = 0

do:	addu	$t0,$a0,$t2	# $t0 = dst[i]
	addu	$t1,$a1,$t2	# $t1 = src[i]
	
	lb	$t3,0($t1)	# dst[i] = src[i]
	sb	$t3,0($t0)
	addi	$t2,$t2,1	# i++
	
	bne	$t3,'\0',do	# while(src[i]!= '\0')
	move	$v0,$a0		# return dst
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
		
		
		
		
# Sub-rotina Terminal
# recebe string em $a0
# retorna $v0
# $t0 - len

strlen:	li	$t0,0
	
	
while3:	lb	$t1,0($a0)
	addiu	$a0,$a0,1
	beq	$t1,'\0',endw3		# while(*s++ != '\0')
	addi	$t0,$t0,1		#LEN++
	j	while3
endw3:	move	$v0,$t0			# return len
	jr	$ra
	
	
	
