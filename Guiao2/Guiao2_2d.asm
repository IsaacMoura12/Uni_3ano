	.data
	.text
	.globl main
	
	#Programa que converte grey code em binário:
	
	
main:	ori	$t0,$0,8		#valor a converter(gray)
	ori	$t1,$t0,0		# num = gray
	ori	$t2,$t0,0		# valor em binário(bin)
	
	
	
	srl	$t1,$t1,4		# num = num >>4
	xor	$t1,$t0,$t1		# num = numm ^ num >>4
	
	srl	$t2,$t1,2		# bin = num >> 2
	xor	$t1,$t1,$t2		# num = num ^ bin
	
	srl	$t2,$t1,1		# bin = num >>1
	xor	$t1,$t1,$t2		# num = num ^bin
	
	ori	$t2,$t1,0		# bin = num
	
	
	jr	$ra
