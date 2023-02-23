# Mapa de Registos
# $a0 - argc
# $a1 - argv
# $t0 - i

	.data
	.eqv print_string,4
	.eqv print_int10,1
	
str1:	.asciiz "Nr. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
	.text
	.globl main
	
main:	li	$t0,0			# i = 0
	move 	$t1,$a0			# $t1 = argc
	move 	$t2,$a1			# $t2 = argv
	
	li	$v0,print_string
	la	$a0,str1		# print_str
	syscall
	
	move	$a0,$t1			# $a0 = $t1
	li	$v0,print_int10		# print argc
	syscall

while:	bge	$t0,$t1,endw		# while(i < argc)
	li	$v0,print_string
	la	$a0,str2
	syscall
	
	move	$a0,$t0			# $a0 = i
	li	$v0,print_int10
	syscall
	
	li	$v0,print_string	# print_string
	la	$a0,str3
	syscall
	
	
	sll	$t3,$t0,2		# i * 4
	addu	$t4,$t2,$t3		# array + i
	lw	$t4,0($t4)		# array[i]
	

	li	$v0,print_string	#print_string
	move	$a0,$t4
	syscall
	
	addi	$t0,$t0,1		# i ++
	j	while
	
	
endw:	li	$v0,0			# return 0
	jr	$ra
	
	
