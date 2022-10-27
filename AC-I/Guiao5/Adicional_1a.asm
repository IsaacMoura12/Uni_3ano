# Mapa de Registos:
# $t0 - i
# $t1 - lista
# $t2 - lista + i
# $t3 - j
# $t4 -  lista[i]
# $t9 - lista + j
# $t5 - lista[j]
# $t6 - houve_troca
# $t7 - aux
# $t8 - size -1


# Programa que ordena por ordem crescente elementos de array de inteiros:
# sequencial sort (indices)

	.data
	.eqv read_int,5
	.eqv print_string,4
str:	.asciiz "Conteudo do array ordenado:\n"
str2:	.asciiz "; "
str1:	.asciiz "Introduza um numero:"
	.align 2
lista:	.space 40 			# (size * 4)
	.eqv SIZE,10
	.eqv print_int10,1
	.eqv print_string,4

	.text
	.globl main
	
main:	li	$t0,0			# i = 0

#### preencher lista
while:	beq	$t0,SIZE,endw		# while i < 10
	
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
## Fim codigo prencher a lista
endw:	la	$t1,lista		# $t1 = 1 endereço da lista

	li	$t0,0			# i = 0
	li	$t8,SIZE
	sub	$t8,$t8,1		# $t8 = size -1
	
	li	$t0,0			# i = 0
while1:	bge	$t0,$t8,endw1		# while(i < size -1)
	

	addi	$t3,$t0,1		# j = i+1
while2:	bge	$t3,SIZE,endw2		# while ( j< size)
	
if:	sll	$t2,$t0,2
	addu	$t2,$t2,$t1		# manipular i
	
	sll	$t9,$t3,2
	addu	$t9,$t9,$t1		# manipular j
	lw	$t4,0($t2)		# lista[i] = $t4
	lw	$t5,0($t9)		# lista[j] = $t5
	
	ble	$t4,$t5,endif		# if lista[i] > lista[j]
	#la	$t7,$t3			# aux = lista[i]
	sw	$t4,0($t9)		# lista[i] = lista[j]
	sw	$t5,0($t2)		# lista[j] = aux (lista[i])
endif:	
	addi	$t3,$t3,1		# j++
	j	while2
endw2:
	addi	$t0,$t0,1		# i++
	j	while1
endw1:
	li	$v0,print_string	# print string
	la	$a0,str
	syscall
	
	la	$t0,lista		# $t0 - primeiro endereço (p)
	
	li	$t2,SIZE
	sub	$t2,$t2,1		# pultimo = size -1
	sll	$t2,$t2,2		# pultimo - $t2
	addu	$t2,$t0,$t2		# ultimo = lista+ size
	
while3:	bgt	$t0,$t2,endw3		# while(p<= ultimo)
	lw	$t1,0($t0)		# $t1 = *p
	addiu	$t0,$t0,4		# p++ (4bytes)
	
	li	$v0,print_int10		# print_int
	move	$a0,$t1
	syscall
	
	li	$v0,print_string	# print_string
	la	$a0,str2
	syscall
	
	j	while3


endw3:	jr	$ra