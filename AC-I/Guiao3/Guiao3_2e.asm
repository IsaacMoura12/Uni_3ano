#Mapa de Registos:
# $t0 - value
# $t1 - bit
# $t2 - i
# $t4 - flag 	

	# Programa que le numero do tclado e converte em binário
	# Imprimir um espaço entre sequencias de 4 bit
	# Elimina zeros à esquerda


	.data
str1:	.asciiz	"Intrroduza um numero:"
str2:	.asciiz	"O valor em binario e:\n "

	.eqv	print_string,4
	.eqv	read_int10,5
	.eqv	print_char,11
	
	.text
	.globl main
	
main:	la	$a0,str1		# print str
	li	$v0,print_string
	syscall
	
	li	$v0,read_int10		# ler valor do teclado
	syscall
	or	$t0,$v0,$0		#guardar em $t0
	
	la	$a0,str2		# print str
	li	$v0,print_string
	syscall
	
	li	$t2,0			# i = 0
	li	$t4,0			# flag = 0

	
do:	srl	$t1,$t0,31		# bit = ( value & 0x8000000) >> 31

if:	beq	$t4,1,then		# flag =! 1 
	beq	$t1,0,endif
	
then:	li	$t4,1
	
if2:	rem	$t3,$t2,4		# if(i%4==0)
	bne	$t3,0,endif2
	
	ori	$a0,$0,' '		#print " "
	li	$v0,print_char
	syscall
	
endif2:	addi	$t3,$t1,0x30		# (0x30 + bit)
	or	$a0,$t3,$0
	li	$v0,print_char
	syscall	
endif:	sll	$t0,$t0,1		#value = value << 1
	addi	$t2,$t2,1		# i++
	blt	$t2,32,do
	j	endw

	

endw:
	jr	$ra
