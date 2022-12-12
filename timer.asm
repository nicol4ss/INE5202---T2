.data
   	NEW_LINE: .asciiz "...\n"
   	FIM: .asciiz "Fim!\n"
   	
.text
main:
	li 	$v0,30        	# Carrega registrador com pedido de captura do timer do SO.
	syscall			#
	move 	$t9, $a0	#

wait:	
	li 	$v0, 30        	# Carrega registrador com pedido de captura do timer do SO.  
	syscall			#
	move 	$t8, $a0	#
	sub    	$t6, $t8, $t9	#
	sle	$s0, $t6, 5000  # Set se for menor ou igual. Neste exemplo, contagem de at� 2 segundos (+/-).
	bgtz  	$s0, wait	#
		
	li  	$v0, 4		# Terminou o tempo (2 egundos).
	la	$a0, FIM	#
	syscall			#
	
end:
	j	end			
