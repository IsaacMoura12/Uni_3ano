	.data	#0x1001000
str1:	.asciiz "Uma String"    #0x1001000  cada string tem um terminador (0x0000)
str2:	.asciiz "AC1 - P "	#0x1001005


	.eqv	PRINT_STR,4
	.text
	.globl main
	
main:	ori	$v0,$0,PRINT_STR
	la	$a0,str1	#load address = 0x1001005
	syscall
	la	$a0,str2
	syscall



	jr	$ra
