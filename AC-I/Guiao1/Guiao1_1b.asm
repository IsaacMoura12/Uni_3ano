	.data
	.text
	.globl main
	
	# programa y = 3x + 5
	
main:	
	ori $t0,$0,4 # x = $t0 = 4
	
	ori $t1,$0, 5 # valor a somar = 5
	add $t2,$t0,$t0 # 2 * x
	add $t2,$t2,$t0 # 2 * x + x (3 * x)
	add $t2,$t2,$t1
	jr	$ra
	