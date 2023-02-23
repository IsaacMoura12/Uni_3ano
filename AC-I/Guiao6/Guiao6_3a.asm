# Mapa de Registos
# $t0 - i
# $t1 - j
# $t3 - array[i] [j]
#
	.data
	.eqv print_int,1
	.eqv print_string,4
	.eqv print_char,11
	.eqv SIZE,3
stra:	.asciiz	"\nString #"
strb:	.asciiz	": "

array:	.word	str1,str2,str3
str1:	.asciiz "Array "
str2:	.asciiz " de "
str3:	.asciiz "ponteiros"
	.text
	.globl main
# Programa que imprime 3 strings,caracter a caracter,separados pelo
# caracter "-" usando indices:
	
	
	
main:	li	$t0,0			# i = 0


while:	bge	$t0,SIZE,endw		# while(i< SIZE)
	
	
	li	$v0,print_string	#print str
	la	$a0,stra
	syscall
	li	$v0,print_int
	move	$a0,$t0
	syscall
	
	li	$v0,print_char		# print char
	la	$a0,strb
	syscall
	
	la	$t2,array		# inicio array de strings
	sll	$t3,$t0,2		# i * 4
	addu	$t3,$t3,$t2		# array + i
	lw	$t4,0($t3)		# array[i]
	
	# $t3 - primeiro endereço de array
	li	$t1,0			# j = 0
while2:	#sll	$t1,$t1,2
	addu	$t5,$t4,$t1		# $t4 = array[i] + j
	lb	$a0,0($t5)		# $t5 = array[i] [j]
	beq	$a0,'\0',endw2		# while($t5 != '\0')
	
	li	$v0,print_char	# print_string
	
	syscall
	
	li	$v0,print_char		# print_char
	li	$a0,'-'
	syscall
	
	addi	$t1,$t1,1		# j ++
	j	while2
endw2:
	addi	$t0,$t0,1		# i++
	j	while
endw:	jr	$ra
	