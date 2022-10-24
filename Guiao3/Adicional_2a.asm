#Mapa de Registos:
# $t0 - v1
# $t1 - v2
# $t2 - mdor
# $t3 - mdo
# $t4 - res
# $t5 - i
# $t6 - tmp

	# PROGRAMA DE MULTIPLICACAO RECORRENDO A DESLOCAMENTOS E SOMAS
	# versao 4 bit


	.data
str1:	.asciiz	"Intrroduza 2 numero(ate 4 bit):"
str2:	.asciiz	"Resultado:\n "
	.eqv	print_string,4
	.eqv	read_int10,5
	.eqv	print_int10,1
	
	.text
	.globl main
	
main:	li	$t4,0			# res = 0
	li	$t5,0			# i = 0
	
	la	$a0,str1		# print str
	li	$v0,print_string
	syscall
	
	li	$v0,read_int10		# read v1 
	syscall
	or	$t0,$v0,$0		# v1 - $t0
	
	li	$v0,read_int10		# read v2
	syscall
	or	$t1,$v0,$0		# v2 - $t1
	
	andi	$t2,$t0,0x0F		# mdor = v1 & 0x0F
	andi	$t3,$t1,0x0F		# mdo = v2  & 0x0F
	
while:	beq	$t2,0,endw		# while mdor =! 0
	addi	$t5,$t5,1		# i++
	bge	$t5,5,endw		# while i++ < 4

if:	andi	$t6,$t2,0x00000001	# tmp = mdor & 0x00000001
	beq	$t6,0,endif		# if(tmp =!0)
	add	$t4,$t4,$t3		# res = res + mdo
	
endif:	sll	$t3,$t3,1		# mdo = mdo << 1
	srl	$t2,$t2,1		# mdor = mdor >> 1
	
	j	while
	
		
endw:	la	$a0,str2
	li	$v0,print_string
	syscall
	
	li	$v0,print_int10
	or	$a0,$t4,$0
	syscall

	jr	$ra
