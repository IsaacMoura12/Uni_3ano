# Mapa de registos:
# $t0 - num
# $t1 - p
# $t2 - *p

# PROGRAMA QUE LE STRING DO TECLADO E CONTA CARACTERES NUMERICOS(PONTEIROS)

	.data
	.eqv	SIZE,20
	.eqv	read_string,8
	.eqv	print_int10,1
	
str:	.space 21
	
	.text
	.globl main
	
	
main:	la	$a0,str			# tamanho maximo da string (BUFFER)
	li	$a1,SIZE		# length da string
	li	$v0,read_string		# read string ( fica em $v0)
	syscall
	
	la	$t1,str			# p = str
	li	$t0,0			# num = 0
	
while:	lb	$t2,0($t1)		# aceder ao elemento da string
	beq	$t2,'\0',endw		# while(*p != '\0')
	
	blt	$t2,'0',endif		#if(str[i] >= '0' && str[i] < '9'
	bgt	$t2,'9',endif
	addi	$t0,$t0,1		# num ++
	
endif:	addiu	$t1,$t1,1		# p++, passa para posiçao seguinte
	j	while			

endw:	or	$a0,$t0,$0		# print numeros
	li	$v0,print_int10
	syscall
	
	jr	$ra
