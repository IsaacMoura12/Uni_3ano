# Mapa de registos:
# val - $t0
# res - $f0
		.data
k1:		.float	2.59375
k2:		.float	0.0
		.text
		.globl main
	
main:
do:	li	$v0,5
	syscall
	move	$t0,$v0			# val = read_int()
	mtc1	$t0,$f0			# passar valor a converter
					# para co processor 1
	cvt.s.w	$f0,$f0			# $f0 = (float)val			
	la	$t1,k1
	l.s	$f2,0($t1)		# $f2 = 2.59375
	
	mul.s	$f0,$f0,$f2		# res = val * 2.59375
	
	li	$v0,2			# print_float(res)
	mov.s	$f12,$f0
	syscall

	la	$t1,k2
	l.s	$f2,0($t1)		# $f2 = 0.0
	
	c.eq.s	$f0,$f2			# while(res!= 0.0)
	bc1f	do
	
	li	$v0,0			# return 0
	jr $ra