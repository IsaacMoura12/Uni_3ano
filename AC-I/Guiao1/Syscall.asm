	.data
	.text
	.globl main

main:	ori	$v0,$0,5   #definir qual a syscall
	syscall		   #chamar a stscall
	
	jr	$ra