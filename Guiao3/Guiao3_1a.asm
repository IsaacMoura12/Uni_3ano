	
# Mapa de registos:
#	$t0 - soma
#	$t1 - value
#	$t2 - i	
	
	
	.data
	
str1:	.asciiz	"Introduza um numero: "
str2:	.asciiz "A soma dos positivos e: "
str3:	.asciiz "Valor ignorado\n"

	.eqv	print_string,4
	.eqv	read_int,5
	.eqv	print_int10,1
	
	.text
	.globl main
	
	# Programa lê 5 valores do teclado e soma os Positivos
	
	
main:	li	$t0,0	#soma = 0
	li	$t2,0	# i = 0
	
while:	bge	$t2,5,endw		# while(i<5)
	
	la	$a0,str1		#print insere numero	
	ori	$v0,$0,print_string
	syscall
	
	ori	$v0,$0,read_int
	syscall
	or	$t1,$v0,$0		#$t1 = valor lido (value)
	
	ble	$t1,$0,else		# if(value >0)
	add	$t0,$t0,$t1		# soma = soma + value
	j	endif
		
else:	la	$a0,str3		# se value <= 0
	ori	$v0,$0,print_string	# print numero ignorado
	syscall
	#j	while			# volta ao inicio(sem incrementar i)
	j	endif
endif:	addi	$t2,$t2,1		#i++ (quando numero e valido)
	j	while




endw:	la	$a0,str2		# Apos o ciclo (5 validos)
	ori	$v0,$0,print_string	# imprime o resultado
	syscall
	
	ori	$v0,$0,print_int10
	or	$a0,$0,$t0
	syscall

	jr	$ra
	
		
			
				
					
						
							
									
