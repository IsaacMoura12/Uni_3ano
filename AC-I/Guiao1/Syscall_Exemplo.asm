	.data
	.text
	.globl main

main:	ori	$t1,$0,0x1234  # t1 = 0x1234
	ori	$t2,$0, 0x5678 # t2 = 0x5678
	sub	$t0,$t1,$t2    # subtraçao
	  
	ori	$v0,$0, 1     # escolher o syscall
	or	$a0,$0,$t0	# escolher valor a usar no syscall
	syscall 		# chamar syscall
	
	jr	$ra