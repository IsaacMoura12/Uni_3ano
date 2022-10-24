#Mapa de Registos:
# $t0 - gray
# $t1 - mask
# $t2 - bin
# $t4 - tmp 

	# PROGRAMA COVERTE VALOR EM GRAY PARA BINARIO NATURAL (ITERATIVO)


	.data
str1:	.asciiz	"Intrroduza um numero(Gray):"
str2:	.asciiz	"O valor em binario e:\n "
str3:	.asciiz "Valor em codigo Gray:\n"
str4:	.asciiz "\nValor em Binario:\n"

	.eqv	print_string,4
	.eqv	read_int10,5
	.eqv	print_int16,34  
	
	.text
	.globl main
	
main:	la	$a0,str1		# print str
	li	$v0,print_string
	syscall
	
	
	li	$v0,read_int10		# ler valor do teclado
	syscall
	or	$t0,$v0,$0		# gray = read_int
	
	or	$t2,$t0,$0		# bin = gray
	
	srl	$t4,$t0,1		# $t4 = (gray >> 1)
	or	$t1,$t4,$0			# mask = (gray >> 1)
	
while:	beq	$t1,$0,endw		#while(mask!=0)
	xor	$t2,$t2,$t1
	
	srl	$t1,$t1,1		# mask = mask >> 1
	
	j	while

endw:	la	$a0,str3		# print str
	li	$v0,print_string
	syscall

	or	$a0,$0,$t0		
	li	$v0,print_int16
	syscall
	
	la	$a0,str4		# print str
	li	$v0,print_string
	syscall
	
	or	$a0,$0,$t2		
	li	$v0,print_int16
	syscall

	jr	$ra
