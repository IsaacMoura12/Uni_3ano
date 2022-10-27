# Mapa de Registos:
# $t0 - p
# $t1 - *p
# $t2 - lista + size (pultimo)


# Programa faz print de um array de 10 inteiros
	
	.data
	
	.eqv print_int10,1
	.eqv print_string,4
	.eqv SIZE,10
	
str:	.asciiz "Conteudo do array:\n"
str2:	.asciiz "; "
lista:	.word 8,-4,3,5,124,-15,87,9,27,15

	.text
	.globl main
	
main:	li	$v0,print_string	# print string
	la	$a0,str
	syscall
	
	la	$t0,lista		# $t0 - primeiro endereço (p)
	
	li	$t2,SIZE
	sub	$t2,$t2,1		# pultimo = size -1
	sll	$t2,$t2,2		# pultimo - $t2
	addu	$t2,$t0,$t2		# ultimo = lista+ size
	
while:	bgt	$t0,$t2,endw		# while(p<= ultimo)
	lw	$t1,0($t0)		# $t1 = *p
	addiu	$t0,$t0,4		# p++ (4bytes)
	
	li	$v0,print_int10		# print_int
	move	$a0,$t1
	syscall
	
	li	$v0,print_string	# print_string
	la	$a0,str2
	syscall
	
	j	while


endw:	jr	$ra
	
	
	
	
