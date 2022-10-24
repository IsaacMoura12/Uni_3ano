# Mapa de Registos
# $t0 - p
# $t1 - *p
# $t2 - tmp

# PROGRAMA QUE CONVERTE MINUSCULAS EM MAIUSCULAS (CORRIGIDO)

.data
	.eqv	SIZE,20
	.eqv	read_string,8
	.eqv	print_int10,1
	.eqv	print_string,4
	
str:	.space	21 #(20 para a string +1 para o terminador)
	.text
	.globl main
	
main:	la	$a0,str			# tamanho maximo da string (BUFFER)
	li	$a1,SIZE		# length da string
	li	$v0,read_string		# read string ( fica em $v0)
	syscall
	
	la	$t0,str			# p =str
	
while:	lb	$t1,0($t0)		# *p = elemento a avaliar
	beq	$t1,'\0',endw		# while(*p != '\0')
	
if:	blt	$t1,'a',endif		# se letra nao e minuscula
	bgt	$t1,'z',endif		# ignora
	li	$t2,'a'			# tmp = 'a'
	sub	$t1,$t1,$t2		# *p = *p - 'a'
	addi	$t1,$t1,'A' 		# *P = *P + 'A'
	sb	$t1,0($t0)		# guardar novo valor
	
	addi	$t0,$t0,1		# p++
	j	while
	
endif:	sb	$t1,0($t0)		# guarda valor(inalterado)
	addi	$t0,$t0,1		# p++
	j 	while

endw:	li	$v0,print_string
	la	$a0,str
	syscall
	
	jr	$ra
