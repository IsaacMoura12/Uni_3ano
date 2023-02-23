	.data
	.eqv	print_int10,1
str:	.asciiz "2020 e 2024 sao anos bisextos"
	.text
	.globl main
#Mapa de Registos
# 		
main:	addiu	$sp,$sp,-4
	sw	$ra,0($sp)
	la	$a0,str
	jal	atoi
	move	$a0,$v0
	
	li	$v0,print_int10
	syscall
	li	$a0,0			# return 0
	
	lw	$ra,0($sp)		# atualizar stack pointer
	addiu	$sp,$sp,4
	jr	$ra
	
	






#Sub-rotina Terminal:
# recebe em $a0 o ponteiro para caracter(string)
# res = $v0
# digit = $t1
# *s = $t0
# s = $a0

atoi:	li	$v0,0			# res = 0
	

while:	lb	$t0,0($a0)
	blt	$t0,'0',endw		# while(*s >= '0') and
	bgt	$t0,'9',endw		# (*s <= '9')
	addi	$t1,$t0,-0x30		# digit = *s - '0'
	addiu	$a0,$a0,1		# s++
	mul	$v0,$v0,10		# res = 10 * res
	add	$v0,$v0,$t1		# res = res + digit
	j while
endw:	
	jr	$ra