.data
   	fout: .asciiz "comprovante.txt"
   	PURO: .asciiz "CAFE PURO\n"
   	PEQUENO: .asciiz "PEQUENO\n"
   	
.text

li $v0, 13
la $a0, fout
li $a1, 1
li $a2, 0
move $s6, $v0

li $v0, 15
move $a0, $s6
la $a1, PURO
li $a2, 11
syscall

li $v0, 16
move $a0, $s6
syscall