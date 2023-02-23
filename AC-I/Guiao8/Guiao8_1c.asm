# Mapa de Registos:
# str: $s0
# val: $s1
# main é subrotina intermédia

	.data
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	MAX_STR_SIZE, 33
str:	.space	MAX_STR_SIZE

	.text
	.globl main
	
main:	addiu	$sp,$sp,-8
	sw	$ra,0($sp)
	sw	$s0,4($sp)
	
do1:	li	$v0,read_int
	syscall
	move	$s0,$v0
	
	move	$a0,$s0
	li	$a1,2
	la	$a2,str
	jal	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	move	$a0,$s0
	li	$a1,8
	la	$a2,str
	jal	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	move	$a0,$s0
	li	$a1,16
	la	$a2,str
	jal	itoa
	move	$a0,$v0
	li	$v0,print_string
	syscall
	
	bne	$s0,0,do		# while(val !=0)
	li	$v0,0			# return 0
	sw	$s0,0($sp)
	sw	$ra,4($sp)
	addiu	$sp,$sp,8
				
	jr	$ra





#Sub-rotina Intermédia:
# recebe:
# $a0 - n (numero inteiro)  -> $s0
# $a1 - b (base , varia entre 2 e 16)  -> $s1
# $a2 - s (array de caracteres)	  -> $s2
# p - $s3
# digit - $t0

itoa:	addiu	$sp,$sp,-20		#reserva espaço na stack(5 elems)
	sw	$s0,0($sp)		# salvaguardar registos
	sw	$s1,4($sp)
	sw	$s2,8($sp)
	sw	$s3,12($sp)
	sw	$ra,16($sp)
	
	move	$s0,$a0			# copiar entradas para registos seguros
	move	$s1,$a1
	move	$s2,$a2
	move	$s3,$a2			# p = s
	
do:	rem	$t0,$s0,$s1		# digit = n % b
	div	$s0,$s0,$s1		# n = n / b
	move	$a0,$t0			# $a0 = digit
	jal	toascii
	sb	$v0,0($s3)		# *p = toasciiz(digit)
	addiu	$s3,$s3,1		# p++
	bgt	$s0,0,do		# while(n>0)
	sb	$0,0($s3)		# *p = '\0'
	move	$a0,$s2
	jal	strrev
	move	$v0,$s2
	
	lw	$s0,0($sp)		# salvaguardar registos
	lw	$s1,4($sp)
	lw	$s2,8($sp)
	lw	$s3,12($sp)
	lw	$ra,16($sp)
	addiu	$sp,$sp,20
	jr	$ra
	
#Sub-rotina Terminal
# em $a0 char v
# devolve em $v0 correspondente em asciiz
toascii:	addi	$v0,$a0,'0'
if:		ble	$v0,'9',endif
		addi	$v0,$v0,7
		
endif:		jr	$ra



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
