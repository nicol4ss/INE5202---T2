.data
   	NEW_LINE: .asciiz "...\n"
   	FIM: .asciiz "Fim!\n"
   	
.text
main:
	li 	$v0,30        	# Carrega registrador com pedido de captura do timer do SO.
	syscall			#
	move 	$t1, $a0	#

	li  	$v0, 1		# Mostra valor capturado na tela (inteiro).
	move	$a0, $t1	#
	syscall			#

	li  	$v0, 4		# Coloca ... depois do n�mero capturado (string). Obs.: apenas est�tico.
	la	$a0, NEW_LINE	#
	syscall			#

wait:	
	li 	$v0, 30        	# Carrega registrador com pedido de captura do timer do SO.  
	syscall			#
	move 	$t0, $a0	#
	sub    	$t2, $t0, $t1	#
	sle	$s0, $t2, 2000  # Set se for menor ou igual. Neste exemplo, contagem de at� 2 segundos (+/-).
	bgtz  	$s0, wait	#
		
	li  	$v0, 4		# Terminou o tempo (2 egundos).
	la	$a0, FIM	#
	syscall			#
	
end:
	j	end			
