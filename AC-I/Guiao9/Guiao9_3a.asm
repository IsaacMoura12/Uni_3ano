#Mapa de Registos:
# $t0 - i
# $t1 - a
# $t2 - aux
# $t3 - a[i]
		
		.data
		.eqv SIZE, 80
a:		.space	80
		.text
		.globl main
		
main:	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	li	$t0,0			# i= 0
	la	$t1,a
	
while:	bge	$t0,SIZE,endw		# while(i < SIZE)
	
	sll	$t2,$t0,3		# i * 8
	addu	$t3,$t1,$t2		# $t3 = a[i]
	
	li	$v0,5
	syscall
	
	mtc1	$v0,$f2			# mover $v0 para cp1
	cvt.d.w	$f2,$f2			# $f2 = (double)$v0
	s.d	$f2,0($t3)	
	addi	$t0,$t0,1		# i++
	j	while

endw:	la	$a0,a			# PASSAR PARAMETROS PARA FUNCAO
	li	$a1,SIZE
	jal	average
	
	mov.d	$f12,$f0		# carregar valor a printar para syscall
	li	$v0,3			# print_double()
	syscall
	
	lw	$ra,0($sp)
	addiu	$sp,$sp,4
	li	$v0,0			# return 0
	jr	$ra

#Sub-rotina Terminal
# a : $a0
# n : $a1
# retorno : $f0
# i : $t0
# sum : $f0
		
average:	move	$t0,$a1		# i = n
		mtc1	$0,$f0
		cvt.d.w	$f0,$f0		# $f0 = 0.0 / sum = 0.0

while1:	ble	$t0,0,endw1
	

		
				
endw1:		
		



