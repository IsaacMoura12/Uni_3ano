# Mapa de Registos
# $s0 - exit_value
	.data
str1:	.asciiz "I serodatumoC ed arutetiuqrA"
str2:	.space 30	#espaço para a string
str3:	.asciiz	"String too long:"
str4:	.asciiz "\n"
	.eqv print_int10,1
	.eqv print_string,4
	.eqv STR_MAX_SIZE,30
	
	.text
	.globl main
	
	
main:	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	
	la	$a0,str1
	jal	strlen			# chama subrotina len
					# valor retorno vem em $v0
if:	bgt	$v0,STR_MAX_SIZE,else	# if(strlen(str1) <= Max)
	la	$a0,str2
	la	$a1,str1
	jal	strcpy
	move	$a0,$v0			# guardar result

	li	$v0,print_string
	syscall
	
	li	$v0,print_string
	la	$a0,str4
	syscall
	
	la	$a0,str2
	jal	strrev
	move	$a0,$v0
		
	li	$v0,print_string
	
	syscall
	
	li	$s0,0			# exit_value=0
	j	endif
	
else:	li	$v0,print_string
	la	$a0,str3
	syscall
	
	la	$a0,str1
	jal	strlen
	move	$a0,$v0
	li	$v0,print_int10
	syscall
	li	$s0,-1			# exit_value = -1
endif:	
	move	$v0,$s0
	
	lw	$ra,0($sp)		# atualizar stack pointer
	addiu	$sp,$sp,4
	jr	$ra

#Sub-Rotina
#dst: $a0
#src: $a1
#i: $t2
# retorno ($v0) -> *destino
# sub-rotina Terminal
strcpy:	li	$t2,0			# i = 0

do:	addu	$t0,$a0,$t2		# str + i
	addu	$t1,$a1,$t2		# str2 + i
	
	lb	$t3,0($t1)		#src[i]
	sb	$t3,0($t0)		#dst[i] = src[i]
	
	addi	$t2,$t2,1		# i++
while:	bne	$t3,'\0',do		# while(src[i++] != '\0')
	move	$v0,$a0			# return dst
	jr	$ra
 	
 	
#Sub-Rotina
strlen: li $t1,0 			# len = 0; 

while3: lb $t0,0($a0)			# while(*s++ != '\0') 
 	addiu $a0,$a0,1			# 
 	beq $t0,'\0',endw3 		# { 
 	addi $t1,$t1,1			# len++; 
 	j while3			# } 
 
endw3:	move $v0,$t1			# return len; 
 	jr $ra 	
 																
strrev: addiu	$sp,$sp,-16		#reserva espaço na stack
	sw	$ra,0($sp)		# guarda valor retorno
	
	sw	$s0,4($sp)		# guarda valor dos registos
	sw 	$s1,8($sp)		# $s0,$1 e $s2
	sw	$s2,12($sp)
	move	$s0,$a0			# registo callee-saved
	move	$s1,$a0			# p1 = str
	move	$s2,$a0			# p2 = str
	
	
while4:	lb	$t0,0($s2)		# *p2
	beq	$t0,'\0',endw4		# while(*p2 != '\0')
	addiu	$s2,$s2,1		# p2++
	j	while4
endw4:	sub	$s2,$s2,1		#p2--

while2:	bge	$s1,$s2,endw2		# while(p1<p2)
	move	$a0,$s1			# parametros entrada
	move	$a1,$s2			# para sub-rotina exchange
	jal	exchange		# chama sub-rotina
	addi	$s1,$s1,1		# p1++
	sub	$s2,$s2,1		# p2--
	j	while2
	
endw2:	move	$v0,$s0			# epilogo
	lw	$ra,0($sp)
	lw	$s0,4($sp)
	lw	$s1,8($sp)
	lw	$s2,12($sp)
	addiu	$sp,$sp,16
	jr $ra 	
#c1: $a0
#c2 : $a1
#Sub-rotina Terminal			
exchange:	lb	$t0,0($a0)
		lb	$t1,0($a1)
		sb	$t0,0($a1)
		sb	$t1,0($a0)
 		jr	$ra
