	.data
	.text
	.globl main

main:	# y = 2x - 8

	ori $t0,$0,4 # x = 4
	
	ori $t2,$0,8  # constante a subtrair
	add $t1,$t0,$t0 # 2 * x 
	sub $t1,$t1,$t2	# y = 2 * x -8 (0)
	
	jr	$ra
	
	
	