		.data
str1:		.asciiz "2020 e 2024 sao anos bissextos"
		.eqv print_int10,1
		.text
		.globl main
		
		
main:	addiu	$sp,$sp,-4		#epilogo
	sw	$ra,0($sp)
	
	la	$a0,str1
	jal	atoi
	move	$a0,$v0
	li	$v0,print_int10
	syscall
	
	li	$v0,0			#return 0
	
	lw	$ra,0($sp)		# prologo
	addiu	$sp,$sp,4
	jr	$ra

# Sub rotina Terminal
# $a0 - ponteiro para str
# $v0 - devolve valor numerico da string

atoi:	li	$t3,0		# res = 0
	
while:	lb	$t1,0($a0)	# $t1 = s
	blt	$t1,'0',endw	# while (s >= '0') &&
	bgt	$t1,'9',endw	# (s<= '9')
	sub	$t2,$t1,'0'	# digit = s++ - '0'
	addiu	$a0,$a0,1	# s++
	mul	$t3,$t3,10	# 10 * res
	add	$t3,$t3,$t2	# res = 10 * res + digit
	j	while	
			
endw:	move	$v0,$t3		# return res
	jr	$ra	