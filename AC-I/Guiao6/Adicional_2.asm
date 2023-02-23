# Mapa de Registos
# $a0 - argc
# $a1 - argv
# $t0 - i
# $t3  
# $t5 - j
# $t7 - numero
# $t8 - minuscula
# $t9 - maiuscula

	.data
	.eqv print_string,4
	.eqv print_int10,1
	.eqv print_char,11
	
str1:	.asciiz "Nr. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ":\n "
str4:	.asciiz "Numero de digitos:"
str5:	.asciiz "\nNumero de letras minusculas:"
str6:	.asciiz "\nNumero de letras maiusculas:"
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
	
	li	$t5,0		# j = 0
	
while2:	addu	$t6,$t4,$t5		# $t6 = word +j
	lb	$t7,0($t6)		# cada letra 
	beq	$t7,'\0',endw2
	
if:	blt	$t7,'0',endif
	bgt	$t7,'9',endif
	addi	$t8,$t8,1

endif:
if2:	blt	$t7,'a',endif2
	bgt	$t7,'z',endif2
	addi	$t9,$t9,1
	
endif2:
if3:	blt	$t7,'A',endif3
	bgt	$t7,'Z',endif3
	addi	$s0,$s0,1
endif3:
	
	addi	$t5,$t5,1		#j++
	j	while2
	
endw2:	li	$v0,print_string
	la	$a0,str4
	syscall
	li	$v0,print_int10
	move	$a0,$t8
	syscall
	
	li	$v0,print_string
	la	$a0,str5
	syscall
	li	$v0,print_int10
	move	$a0,$t9
	syscall
	
	li	$v0,print_string
	la	$a0,str6
	syscall
	
	li	$v0,print_int10
	move 	$a0,$s0
	syscall
	
	
	
	
	
	addi	$t0,$t0,1		# i ++
	li	$t8,0
	li	$t9,0
	li	$s0,0
	j	while
	
	
endw:	li	$v0,0			# return 0
	jr	$ra
	