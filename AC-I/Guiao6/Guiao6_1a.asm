#Mapa de Registos:
# $t0 - i
# $t1 - array
# $t2- array+ i
# $t3 - array[i]

#Progama define 3 strings organizadas em estrutura de dados
# e imprime-as:

	.data
	.eqv print_string,4
	.eqv SIZE,3
array:	.word	str1,str2,str3
str1:	.asciiz "Array "
str2:	.asciiz " de "
str3:	.asciiz "ponteiros"

	.text
	.globl main
	
main:	li	$t0,0			# i = 0

while:	bge	$t0,SIZE,endw		# while(i<SIZE)
	la	$t1,array
	sll	$t2,$t0,2		# i * 4 para aceder á word
	addu	$t2,$t1,$t2		# array + i
	lw	$a0,0($t2)		#$a0 = array[i]
	
	li	$v0,print_string
	syscall


	addi	$t0,$t0,1 # i ++
	j	while

endw: jr	$ra