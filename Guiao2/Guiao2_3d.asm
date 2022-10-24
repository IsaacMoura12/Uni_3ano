	.data
	
str1:	.asciiz	"Introduza 2 numeros\n"
str2:	.asciiz	"A soma dos dois numeros e: "
	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_int10,1
	
	
	.text
	.globl main
	
	
main:	la	$a0,str1		# carregar str1 para o syscall
	ori	$v0,$0,print_string	# chamar o syscall (4=print_string)
	syscall
	
	ori	$v0,$0,read_int		# chamar syscall (5=read_int)
	syscall				# valor lido retorna em $v0
	or	$t0,$v0,$0		# gravar $v0 em $t0
	
	ori	$v0,$0,read_int		# chamar syscall (5=read_int)
	syscall				# valor lido retorna em $v0
	or	$t1,$v0,$0		# gravar $v0 em $t1
	
	add	$t2,$t0,$t1		# $t2 = $t0 + $t1
	
	la	$a0,str2		#carrega str2 para o syscall
	ori	$v0,$0,print_string	# chama o syscall (print_string)
	syscall	
	
	ori	$v0,$0,print_int10	#carrega syscall(print_int
	or	$a0,$0,$t2		# valor de $a0 = $t2, para o syscall
	syscall
	
		
	
	jr	$ra
	
	
	
	
	
	