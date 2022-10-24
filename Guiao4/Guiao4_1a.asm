# Mapa de registos
# num - $t0
# i - $t1
# str - $t2
# str+ i - $t3
# str[i] - $t4
# tmp - $t5


# PROGRAMA QUE LE STRING DO TECLADO E CONTA CARACTERES NUMERICOS:

	.data
	.eqv	SIZE,20
	.eqv	read_string,8
	.eqv	print_int10,1
	#.align 2
str:	.space 21	# 20 + 1
	
	.text
	.globl main

main:	
	la	$a0,str			# tamanho maximo da string (BUFFER)
	li	$a1,SIZE		# length da string
	li	$v0,read_string		# read string ( fica em $v0)
	syscall
	
	li	$t0,0			# num = 0
	li	$t1,0			# i = 0
	
while:	#beq	$t4,'\n',endw		# while str[i] != "\n"
	la	$t2,str
	#sll	$t3,$t1,1			# $t2 = &str[0]
	addu	$t3,$t2,$t1		# str +i = &str[i]
	lb	$t4,0($t3)		# $t4 = str[i]
	beq	$t4,$0,endw		# while str[i] != "\n"

if:	blt	$t4,'0',endif		# str[i] >= '0'
	bgt	$t4,'9',endif		# and str[i] < '9'
	addi	$t0,$t0,1		# num++
	
endif:	addi	$t1,$t1,1		# i++
	j	while

endw:	or	$a0,$t0,$0		# print numeros
	li	$v0,print_int10
	syscall
	
	jr	$ra

