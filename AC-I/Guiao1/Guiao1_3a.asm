	.data
	.text
	.globl main
	
	# y = 2 x - 8 ,, ler do teclado o valor de x e imprimir y

main:	ori $v0,$a0,5   # chama o syscall de ler teclado
	syscall
	
	ori $t2,$a0,8   # valor a subtrair
	or  $t0,$0,$v0  # guarda valor de x em t0
	add $t1,$t0,$t0 # 2 * x
	sub $t1,$t1,$t2 # 2 * - 8
	
	ori $v0,$a0,1 # chama a syscall de imprimir no ecra
	or  $a0,$a0,$t1 # escolhe o valor a usar no syscall
	syscall
	
	jr	$ra