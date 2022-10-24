	.data
	.text
	.globl main
	
	
	
	#PROGRAMA QUE FAZ A CONVERSÃO ENTRE BINÁRIO E CÓDIGO GREY
	
	
main:	ori	$t0,$0,4
	ori	$t1,$0,0
	
	
	srl	$t1,$t0,1
	xor	$t1,$t0,$t1
		
	
	
	jr	$ra