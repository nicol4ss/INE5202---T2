#text segment declarar matriz como uma word  
#reservar endere�o para matriz trasnposta e onde colocar  
#vai multiplicando at� o endere�o de mam�ria  
.data 
 save1:  .word 1, 2, 0, 1, -1, -3, 0, 1, 3, 6, 1, 3, 2, 4, 0, 3 
 espa�oTransposta: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0


 
.text 


 main:   
 la $s0, save1 #endere�o da matriz inteira que � a original 
 la $s1, espa�oTransposta #endere�o da matriz que vai ser o resultado 
 li $s2, 0   
 li $s3, 0 
  
#valores v�o ser deslocando at� chegar ao endere�o correto 
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
 

 
