.data

MatrizA: .word 	1, 2, 3, 0, 1, 4, 0, 0, 1
MatrizB: .word 	1, -2, 5, 0, 1, -4, 0, 0, 1
MatrizResultado: .word	1
	
.text
main:
#carrega o endereço das Matrizes em cada registrador
la $s0, MatrizA		
la $s1, MatrizB		
la $s2, MatrizResultado	
		
#variaveis usadas nos loops
li $s3, 0
li $s4, 0  	
li $s5, 0	
li $t6, 0 	

	
LOOP1:
mul $t0, $s3, 3	#tamanho da matriz
mul $t1, $s5, 3	#tamanho da matriz
	
#posição
add $t0, $t0, $s5	
add $t1, $t1, $s4	
add $t2, $t0, $s4	
sll $t0, $t0, 2	
sll $t1, $t1, 2	
sll $t2, $t2, 2	
add $t0, $t0, $s0	
add $t1, $t1, $s1	
add $t2, $t2, $s2	
	
#carrega os valores
lw $t3, 0($t0)	
lw $t4, 0($t1)	
mul $t5, $t3, $t4	
add $t6, $t6, $t5 # faz a soma	
addi $s5, $s5, 1	
bge $s5, 3, LOOP2 #se $s0 for maior igual que 3 vai pro loop2	
j LOOP1		
	
LOOP2:
sw $t6, 0($t2) #armazena o valor da soma	
li $s5, 0	#reset
addi $s4, $s4, 1	
li $a0, 0	#reset	
add $a0, $a0, $t6	
li $t6, 0	
bge $s4, 3, LOOP3 #se $s0 for maior igual que 3 vai pro loop3  
j LOOP1		

LOOP3:
li $s4, 0	#reset	
addi $s3, $s3, 1	
bge $s3, 3, EXIT #se $s0 for maior igual que 3 vai pro exit
j LOOP2	
EXIT:
