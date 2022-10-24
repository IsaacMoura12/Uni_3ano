	.data
	
	.text
	.globl main
	
main:	# programa que implementa a expressão Y = 2X + 8

	ori $t0,$0,10	# $t0 = valor x
	
	ori $t2,$0,8 # $t2 = 8
	add $t1,$t0,$t0  # $t1 = $t0 + $t0 ||  X +X = 2 * X
	add $t1,$t0,$t2	 # $t1 = $t1 + $t2 ||  y = 2 * x + 8
	jr	$ra
	
	
	
	