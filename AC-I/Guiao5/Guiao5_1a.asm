# Mapa de Registos:
# $t0 - i
# $t1 - array (lista)
# $t2 - lista + i
# $t3 - valor tmp


# Programa que le 5 valores do teclado e armazena em lista

	.data
	
	.eqv SIZE,5
str1:	.asciiz "Introduza um numero:"
	.align 2
lista:	.space 20 # (size * 4)
	.eqv read_int,5
	.eqv print_string,4


	.text
	.globl main
	
main:	li	$t0,0			# i = 0

while:	beq	$t0,SIZE,endw		# while i < 5
	
	li	$v0,print_string	#print_string
	la	$a0,str1
	syscall
	
	li	$v0,read_int		# read_int
	syscall
	
	
	la	$t1,lista		# endereço inicial lista
	sll	$t2,$t0,2		# i * 4 (4bytes)
	addu	$t2,$t1,$t2		# stri + i
	sw	$v0,0($t2)		# guarda valor lido
	addi	$t0,$t0,1		# i ++
	j	while
	
	
	



endw:


	jr	$ra
	
