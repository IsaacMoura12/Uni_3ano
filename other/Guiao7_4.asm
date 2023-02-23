		.data
str1:		.asciiz "Arquitetura de "
str2:		.space 50
str3:		.asciiz	"\n"
str4:		.asciiz "Computadores I"
		.eqv	print_string,4
		.text
		.globl main
		
		
main:	addiu	$sp,$sp,-4		#epilogo
	sw	$ra,0($sp)
	
	la	$a0,str2
	la	$a1,str1
	jal	strcpy
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	la	$a0,str3
	li	$v0,print_string
	syscall
	
	la	$a0,str2
	la	$a1,str4
	jal	strcat
	move	$a0,$v0
	li	$v0,print_string
	syscall
	li	$v0,0			#return 0
	
	lw	$ra,0($sp)		# prologo
	addiu	$sp,$sp,4
	jr	$ra


# sub rotina intermedia
# $a0 - dst
# $a1 - src
# $v0 - dst

strcat:	addiu	$sp,$sp,-8		# epilogo
	sw	$ra,0($sp)
	sw	$s0,4($sp)
	
	move	$s0,$a0			# guarda dst em local seguro

while5:	lb	$t1,0($a0)		# $t1 - p
		
	beq	$t1,'\0',endw5		# while(*p != '\0')
	addiu	$a0,$a0,1		# p++
	j	while5
	
endw5:	
	jal	strcpy
	move	$v0,$s0
	
	lw	$ra,0($sp)		# prologo
	lw	$s0,4($sp)
	addiu	$sp,$sp,8
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
	
	