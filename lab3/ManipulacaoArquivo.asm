#text segment declarar matriz como uma word  
#reservar endereço para matriz trasnposta e onde colocar  
#vai multiplicando até o endereço de mamória  
.data 
 save1:  .word 1, 2, 0, 1, -1, -3, 0, 1, 3, 6, 1, 3, 2, 4, 0, 3 
 espaçoTransposta: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 fout: .asciiz "transposta1.dat"
 matrizResultado: .asciiz "                                "

 
.text 


 main:   
 la $s0, save1 #endereço da matriz inteira que é a original 
 la $s1, espaçoTransposta #endereço da matriz que vai ser o resultado 
 li $s2, 0   
 li $s3, 0 
  
#valores vão ser deslocando até chegar ao endereço correto 
 LOOP1: 
 sll $t0, $s2, 2  
 sll $t1, $s3, 2  
 add $t0, $t0, $s3  
 add $t1, $t1, $s2  
 sll $t0, $t0, 2  
 sll $t1, $t1, 2  
 add $t0, $t0, $s0 
 add $t1, $t1, $s1  
 lw $t2, 0($t0) 
 sw $t2, 0($t1)  
 li $a0, 0   
 add $a0, $a0, $t2  
 li $v0, 1 
 
 addi $s3, $s3, 1 
 bge $s3, 4, LOOP2 
 j LOOP1 
 
 LOOP2: 
 li $s3, 0 
 addi $s2, $s2, 1 
 bge $s2, 4, EXIT 
 j LOOP1 
  
 EXIT:
 
 ##### Abrir um arquivo para escrita  #####
	li $v0, 13 		# Comando para abrir novo arquivo
	la $a0, fout 		# Carrega nome do arquivo a ser aberto 
	li $a1, 1 		# Aberto para escrita (flags são 0: read, 1: write)
	li $a2, 0 		# Modo ignorado (neste caso) 
	syscall 		# Abre arquivo (descritor do arquivo é colocado em $v0)
	move $s7, $v0 		# Salva o descritor do arquivo para uso no fechamento, por exemplo
	
##### Escrever no arquivo aberto #####
	li $v0, 15 			# Comando para escrever no arquivo 
	move $a0, $s7 			# Descritor do arquivo é passado
	la $a1, matrizResultado        # Endereço do buffer do qual será copiado para o arquivo 
	li $a2, 64			# Tamanho do buffer (hardcoded)
	syscall 			# Escreve no arquivo
	
##### Fechar o arquivo após escrever #####
	li $v0, 16 		# Comando para fechamento do arquivo
	move $a0, $s7 		# Descritor do arquivo é passado
	syscall 		# Arquivo é fechado pelo sistema operacional
	
 
