
#Mapa de Registos:
# $t0 - value
# $t1 - bit
# t2 - i	

	# Programa que le numero do tclado e converte em binário
	# Imprimir um espaço entre sequencias de 4 bit


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
	
while:	bge	$t2,32,endw		# while(i<32)
	
	rem	$t3,$t2,4		# if (i%4==0)
	bne	$t3,0,else1
	
	ori	$a0,$0,' '		#print " "
	li	$v0,print_char
	syscall
	
	
else1:	andi	$t1,$t0,0x80000000	# isola bit
	
	beq	$t1,$0,else		#verifica se bit=!0
	
	ori	$a0,$0,'1'		#print 1 se bit!=0
	li	$v0,print_char
	syscall
	j	endif
	
		
else:	ori	$a0,$0,'0'		#print 0 se bit = 0
	li	$v0,print_char
	syscall
	j	endif
	

endif:	sll	$t0,$t0,1		#value = value << 1
	addi	$t2,$t2,1		# i++

	j while

endw:
	jr	$ra
	
	
	
	
	
	
	