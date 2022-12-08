# T2 - MAQUINA DE CAFE - NICOLAS ELIAS SANTANA - 20200419
.data
    NEW_LINE: .asciiz "...\n"
    coffes: .asciiz "SELECIONE O TIPO DE CAFE:\n  1 = CAFE PURO;\n  2 = CAFE COM LEITE;\n  3 = MOCHACCINO\n"
    lens: .asciiz "SELECIONE O TAMANHO:\n  1 = PEQUENO;\n  2 = GRANDE\n"
    sugars: .asciiz "ADICIONAR AÇUCAR?:\n  1 = SIM;\n  0 = NÃO\n"
   	FIM: .asciiz "Cafe pronto!\n"
.text

li 	$v0, 30        	# Carrega registrador com pedido de captura do timer do SO.
syscall	
move 	$t9, $a0

# VARIAVEIS CAFES
li $s1, 20 # coffe
li $s2, 20 # milk
li $s3, 20 # chocolate
li $s4, 20 # sugar

# VAR TAMANHO
li $s5, 0# tamanho
START:
    j TYPECOFFE

TYPECOFFE:
    # MOSTRA TIPOS DE CAFES A SEREM SELECIONADOS
    li  	$v0, 4
	la	$a0, coffes	
	syscall			

    li $v0, 5# PEDE INPUT
    syscall
    move $t3, $v0 # t3 = type

    j TYPELENTGH

TYPELENTGH:
    # TAMANHOS A SEREM SELECIONADOS
    li  	$v0, 4
    la	$a0, lens	
    syscall

    li $v0, 5# PEDE INPUT
    syscall
    move $s5, $v0 # s5 = tamanho
    
    beq $s5, 10, recharge # func escondida para recarregar maquina

SUGAR:
    # TAMANHOS A SEREM SELECIONADOS
    li  	$v0, 4
	la	$a0, sugars	
	syscall

    li $v0, 5
    syscall
    move $t5, $v0 # t5 = açucar

    beq $t5, 1, sim
    beq $t5, 0, nao
sim:
    li $t5, 1
    J CHECK
nao:
    li $t5, 0
    J CHECK

CHECK:
    beq $t3, 1, type1
    beq $t3, 2, type2
    beq $t3, 3, type3
    j TYPECOFFE# VALOR ERRADO RESETA MAQUINA

type1:
    slt $t2, $s1, $s5# VERIFICA SE TEM CAFE SUFICIENTE
    beq $t2, 1, TYPECOFFE# DEU RUIM N TEM CAFE
    j MAKE# deu bom
type2:
    slt $t2, $s2, $s5
    beq $t2, 1, TYPECOFFE# DEU RUIM N TEM MILK TENTA DNV
    slt $t2, $s1, $s5
    beq $t2, 1, TYPECOFFE# DEU RUIM N TEM CAFE TENTA DNV
    j MAKE# deu bom
type3:
    slt $t2, $s3, $s5
    beq $t2, 1, TYPECOFFE# DEU RUIM N TEM CHOCO TENTA DNV
    slt $t2, $s1, $s5
    beq $t2, 1, TYPECOFFE# DEU RUIM N TEM CAFE TENTA DNV
    j MAKE# deu bom

MAKE:
    # LOGICA DE TEMPO A SER CALCULADA DEPOIS
    li $t8, 50# tempo do pequeno
    mul $t9, $t8, $s5# se for grande x2 se for pequeno x1
    beq $t3, 1, make1
    beq $t3, 2, make2
    beq $t3, 3, make3

make1:
    sub $s1, $s1, $s5# cafe
    
    j DIABETE
make2:
    sub $s1, $s1, $s5
    sub $s2, $s2, $s5# milk
    
    j DIABETE
make3:
    sub $s1, $s1, $s5
    sub $s3, $s3, $s5# chocolate
    
    j DIABETE

DIABETE:
    # LOGICA DE ESPERA
	li 	$v0, 30        	# Carrega registrador com pedido de captura do timer do SO.  
	syscall
	move 	$t0, $a0
	sub    	$t2, $t0, $t9
	sle	$s0, $t2, $t8
	bgtz  	$s0, DIABETE
		
	li  	$v0, 4		# Terminou o tempo (2 egundos).
	la	$a0, FIM
	syscall

    li $t8, 1
    slt $t7, $s4, $t8 # ve se tem açucar
    beq $t7, 1, TYPECOFFE
    J IMPRIME

IMPRIME:
    # MOSTRAR RESULTADO,
    J TYPECOFFE# RESETA MAQUINA

recharge:
