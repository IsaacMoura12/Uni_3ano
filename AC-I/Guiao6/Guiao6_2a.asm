#Mapa de Registos:
# $t0 - i
# $t1 - p
# $t2 - *p
# $t3 - p_ultimo


#Progama define 3 strings organizadas em estrutura de dados
# e imprime-as (versao ponteiros)

	.data
	.eqv print_string,4
	.eqv SIZE,3
array:	.word	str1,str2,str3
str1:	.asciiz "Array "
str2:	.asciiz " de "
str3:	.asciiz "ponteiros"

	.text
	.globl main
	
main:	la	$t1,array		# array[0]
	li	$t0,SIZE
	sll	$t0,$t0,2 		# size + 4 (bytes)
	addu	$t3,$t1,$t0		# p_ultimo = array[0] + ultimo

while:	bge	$t1,$t3,endw		# while(p < p_ultimo)		
	lw	$a0,0($t1)		#$a0 = array[i]
	
	li	$v0,print_string	# print
	syscall

	addi	$t1,$t1,4		# p++
	j	while

endw: jr	$ra