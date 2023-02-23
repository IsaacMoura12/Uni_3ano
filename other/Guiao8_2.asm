		.data

		.eqv	MAX_STR_SIZE,33
str:		.space	33	
str1:		.asciiz	"\n"
		.eqv	print_string,4
		.eqv	read_int,5
		.text
		.globl main
		
main:	addiu	$sp,$sp,-8		# epilogo
	sw	$ra,0($sp)
	sw	$s0,4($sp)
	
	li	$v0,read_int
	syscall
	
do2:	move	$s0,$v0			# $s0 = val

	move	$a0,$s0			# primeira chamada
	li	$a1,2
	la	$a2,str
	jal	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	move	$a0,$s0
	li	$a1,8
	la	$a2,str
	jal 	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	move	$a0,$s0
	li	$a1,16
	la	$a2,str
	jal 	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall
	bne	$s0,0,do2		# while (val != 0)
	
	li	$v0,0			# return 0
	
	lw	$ra,0($sp)
	lw	$s0,4($sp)
	addiu	$sp,$sp,8
	jr	$ra			# prologo


# Sub rotina intermedia
# $a0 - int n  (numero inteiro)
# $a1 - int b (base)
# $a2 - ponteiro para caracter (array de caracteres)

itoa:	addiu	$sp,$sp,-20		# epilogo
	sw	$ra,0($sp)
	sw	$s0,4($sp)
	sw	$s1,8($sp)
	sw	$s2,12($sp)
	sw	$s3,16($sp)
	
	
	
	move	$s0,$a0			# $s0 = n
	move	$s1,$a1			# $s1 = b
	move	$s2,$a2			# $s2 = *s
	move	$s3,$a2			# *p = s
	
do:	rem	$t1,$s0,$s1		# digit = n % b
	div	$s0,$s1			# n = n / b
	mflo	$s0		
	move	$a0,$t1
	jal	toascii			# toascii(digit)
	sb	$v0,0($s3)		# p = toascii(digit)
	addiu	$s3,$s3,1		# p ++
	bgt	$s0,0,do		# while(n > 0)
	sb	$0,0($s3)		# *p = '\0'
	
	move	$a0,$s2
	jal	strrev
	move	$v0,$s2
	
			# prologo
	lw	$ra,0($sp)
	lw	$s0,4($sp)
	lw	$s1,8($sp)
	lw	$s2,12($sp)
	lw	$s3,16($sp)
	addiu	$sp,$sp,20
	jr	$ra

# Sub rotina terminal
# $a0 - digito v
# $v0 - converte para codigo ascii

toascii:addi	$v0,$a0,'0'		# v = v + '0'

if3:	ble	$v0,'9',endif3		# if (v > '9')
	addi	$v0,$v0,7		# v = v +7
				
endif3:	
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
	move	$s1,$a0
	move	$s2,$a0
	
while:	lb	$t0,0($s2)		# $t0 = str
	beq	$t0,'\0',endw		# while(*p2 != '\0')
	addiu	$s2,$s2,1		# p2++
	j	while
endw:	addiu	$s2,$s2,-1		#p2--
	
while2:	bge	$s1,$s2,endw2
	move	$a0,$s1
	move	$a1,$s2
	jal	exchange
	addiu	$s1,$s1,1
	addiu	$s2,$s2,-1
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