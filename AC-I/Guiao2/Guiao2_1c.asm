	.data
	.text
	.globl main
	
	
	#Programa que nega (bit a bit) dado valor
	
main:	ori	$t0,$0,0xE543
	
	
	nor	$t1,$t0,$0  #EQUIVALE A UM NOT
	
	jr	$ra
