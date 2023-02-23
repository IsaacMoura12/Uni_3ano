#Sub-Rotina
#dst: $a0
#src: $a1
#i: $t2
# retorno ($v0) -> *destino
# sub-rotina Terminal
strcpy:	move	$t2,$a0			# $t0 = *p dst

do:	lb	$t1,0($a1)		# $t1 = src[i]
	sb	$t1,0($a0)		# dts[i] = src[i]
	
	addiu	$a0,$a0,1		# p++
	addiu	$a1,$a1,1		# p++
	
while:	bne	$t1,'\0',do		# while(src[i++] != '\0')
	move	$v0,$t2			# return dst
	jr	$ra