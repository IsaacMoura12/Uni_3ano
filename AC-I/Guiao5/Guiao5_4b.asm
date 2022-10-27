# Mapa de Registos:
# $t0 - p
# $t1 - *p
# $t2 - p_ultimo
# $t3 - p* +1
# $t6 - houve_troca
# $t7 - aux
# $t8 - size -1


# Programa que ordena por ordem crescente elementos de array de inteiros:

	.data
	.eqv read_int,5
	.eqv print_string,4
str:	.asciiz "Conteudo do array ordenado:\n"
str2:	.asciiz "; "
str1:	.asciiz "Introduza um numero:"
	.align 2
lista:	.space 40 			# (size * 4)
	.eqv FALSE,0
	.eqv TRUE,1
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
endw:	la	$t0,lista
	li	$t2,SIZE
	sub	$t2,$t2,1
	sll	$t2,$t2,2
	addu	$t2,$t0,$t2		#p_ultimo
	
do:	li	$t6,FALSE		# houve_troca = FALSE
	la	$t0,lista
while1:	
	bge	$t0,$t2,endw1		# while p < p_ultimo
	lw	$t1,0($t0)		# *p
	lw	$t3,4($t0)		# *p+1
	
if:	ble	$t1,$t3,endif		# if (*p > p*+1)
	move	$t7,$t1
	sw	$t3,0($t0)		# *p = *p+1
	sw	$t7,4($t0)		# *p+1 = aux
	
	li	$t6,TRUE		# houve_troca == True
	
	
endif:	addiu	$t0,$t0,4		#p++
	
	j	while1

endw1:	sub	$t2,$t2,4		# elimina o ultimo
dowhile:beq	$t6,TRUE,do		# while houve_troca == TRUE
					#codigo impressao do array
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
	