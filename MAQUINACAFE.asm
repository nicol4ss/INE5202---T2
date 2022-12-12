# T2 - MAQUINA DE CAFE - NICOLAS ELIAS SANTANA - 20200419
.data
    out: .asciiz "comprovante.txt"
    NEW_LINE: .asciiz "...\n"
    coffes: .asciiz "SELECIONE O TIPO DE CAFE:\n  1 = CAFE PURO;\n  2 = CAFE COM LEITE;\n  3 = MOCHACCINO\n"
    lens: .asciiz "SELECIONE O TAMANHO:\n  1 = PEQUENO;\n  2 = GRANDE\n"
    sugars: .asciiz "ADICIONAR AÇUCAR?:\n  1 = SIM;\n  0 = NÃO\n"
   	FIM: .asciiz "------------> CAFE PRONTO <------------!\n"

    PURO: .asciiz "CAFE PURO - "
    LEITE: .asciiz "CAFE COM LEITE - "
    MOCHACCINO: .asciiz "MOCHACCINO - "
   	PEQUENO: .asciiz "PEQUENO - "
   	GRANDE: .asciiz "GRANDE - "
   	SIM: .asciiz "AÇUCAR? SIM."
   	NAO: .asciiz "AÇUCAR? NAO."
   	RECARGA: .asciiz "DIGITE O VALOR A SER RECARREGADO PARA CADA TIPO, CASO NÃO QUEIRA RECARREGAR ESSE TIPO DE PÓ DIGITE 0\n"
   	RCAFE: .asciiz "CAFE?\n"
   	RLEITE: .asciiz "LEITE?\n"
   	RCHOCO: .asciiz "CHOCOLATE?\n"
   	RACUCAR: .asciiz "AÇUCAR?\n"
   	RFINALIZA: .asciiz "RECARGA COMPLETA!\n"
   	INICIA: .asciiz "DIGITE 1 PARA INICIAR O ATENDIMENTO\n"
.text

# VARIAVEIS CAFES
li $s1, 20 # coffe
li $s2, 20 # milk
li $s3, 20 # chocolate
li $s4, 20 # sugar

# VAR TAMANHO
li $s5, 0# tamanho
START:
    li  	$v0, 4
	la	$a0, INICIA	
	syscall			

    li $v0, 5# inicia atendimento
    syscall
    move $t9, $v0
    beq $t9, 10, recharge# funcao escondida para recarregar maquina
    beq $t9, 1, TYPECOFFE
    j START# BURRAO N DIGITO CERTO
    
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
    j SUGAR

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
    # LOGICA DE IMPRESSAO
    li $v0, 13
    la $a0, out
    li $a1, 1
    li $a2, 0
    syscall
    move $s6, $v0
    # LOGICA DE TEMPO A SER CALCULADA DEPOIS
    li $t8, 5000# tempo do pequeno
    mul $t5 $t8, $s5# se for grande x2 se for pequeno x1
    beq $t3, 1, make1
    beq $t3, 2, make2
    beq $t3, 3, make3

make1:
    # ESCREVE O TIPO QUE FOI FEITO NO ARQUIVO
    li $v0, 15
    move $a0, $s6
    la $a1, PURO
    li $a2, 12
    syscall
    sub $s1, $s1, $s5# cafe
    
    j wait
make2:
    # ESCREVE O TIPO QUE FOI FEITO NO ARQUIVO
    li $v0, 15
    move $a0, $s6
    la $a1, LEITE
    li $a2, 17
    syscall
    sub $s1, $s1, $s5
    sub $s2, $s2, $s5# milk
    
    j wait
make3:
    li $v0, 15
    move $a0, $s6
    la $a1, MOCHACCINO
    li $a2, 13
    syscall
    sub $s1, $s1, $s5
    sub $s3, $s3, $s5# chocolate
    
    j wait
wait:
    # logica de espera da maquina
    li 	$v0,30        	# Carrega registrador com pedido de captura do timer do SO.
    syscall			#
    move 	$t9, $a0	#

    j DIABETE
DIABETE:
    # LOGICA DE ESPERA
	li 	$v0, 30        	# Carrega registrador com pedido de captura do timer do SO.  
	syscall			#
	move 	$t8, $a0	#
	sub    	$t6, $t8, $t9	#
	sle	$s0, $t6, $t5  # Set se for menor ou igual. Neste exemplo, contagem de at� 2 segundos (+/-).
	bgtz  	$s0, DIABETE	#
		
	li  	$v0, 4		# Terminou o tempo (2 egundos).
	la	$a0, FIM	#
	syscall			#

    li $t8, 1
    slt $t7, $s4, $t8 # ve se tem açucar
    beq $t7, 1, TYPECOFFE
    J IMPRIME

IMPRIME:
    # MOSTRAR RESULTADO
    beq $s5, 1, IMPRIME1
    beq $s5, 2, IMPRIME2

IMPRIME1:
    li $v0, 15
    move $a0, $s6
    la $a1, PEQUENO
    li $a2, 10
    syscall
    J IMPRIME3

IMPRIME2:
    li $v0, 15
    move $a0, $s6
    la $a1, GRANDE
    li $a2, 9
    syscall
    J IMPRIME3

IMPRIME3:
    bgtz $t5, IMPRIME4
    li $v0, 15
    move $a0, $s6
    la $a1, SIM
    li $a2, 12
    syscall
    J START# REINICIA A MAQUINA

IMPRIME4:
    li $v0, 15
    move $a0, $s6
    la $a1, NAO
    li $a2, 12
    syscall
    J START# REINICIA A MAQUINA
    
recharge:
    li  	$v0, 4
	la	$a0, RECARGA
	syscall
    
    li  	$v0, 4
	la	$a0, RCAFE
	syscall
    
    li $v0, 5# PEDE INPUT
    syscall
    move $t3, $v0
    add $s1, $s1, $t3

    li  	$v0, 4
	la	$a0, RLEITE
	syscall
    
    li $v0, 5# PEDE INPUT
    syscall
    move $t3, $v0
    add $s2, $s1, $t3

    li  	$v0, 4
	la	$a0, RCHOCO 
	syscall
    
    li $v0, 5# PEDE INPUT
    syscall
    move $t3, $v0
    add $s3, $s1, $t3

    li  	$v0, 4
	la	$a0, RACUCAR 
	syscall

    li $v0, 5# PEDE INPUT
    syscall
    move $t3, $v0
    add $s4, $s1, $t3

    li  	$v0, 4
	la	$a0, RFINALIZA 
	syscall

    J START
