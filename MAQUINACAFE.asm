// T2 - MAQUINA DE CAFE - NICOLAS ELIAS SANTANA - 20200419
.data
    pequeno: .word p
    grande: .word g
    sim: .word s
    nao: .word n
.text
//SALVA AS LETRA DE SELEÇÃO
la $t6, pequeno
lw $t6, 0($t6)
la $t7, grande
lw $t7, 0($t7)
la $t8, sim
lw $t8, 0($t8)
la $t9, nao
lw $t9, 0($t9)

// VARIAVEIS CAFES
li $s1, 0 // coffe
li $s2, 0 // milk
li $s3, 0 // chocolate
li $s4, 0 // sugar

// VAR TAMANHO
li $s5, 0// tamanho

j TYPECOFE

TYPECOFE:
    li $v0, 5
    syscall
    move $t3, $v0 // t3 = type

    j TYPELENTGH

TYPELENTGH:
    li $v0, 5
    syscall
    move $t4, $v0 // t4 = tamanho
    beq $t4, $t6, len1
    beq $t4, $t7, len1

len1:
    li $t4, 1 // CARREGA COM MULT 1 P PEQUENO
    j SUGAR?
len2:
    li $t4, 2 // CARREGA COM MULTIPLICADOR 2 P GRANDE
    j SUGAR?

SUGAR?:
    li $v0, 5
    syscall
    move $t5, $v0 // t5 = açucar

    beq $t5, $t8, sim
    beq $t5, $t9, nao
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
    j TYPECOFE// VALOR ERRADO RESETA MAQUINA

type1:
    slt $t2, $s1, $s5, 
    beq $t2, 1, TYPECOFE// DEU RUIM N TEM CAFE
    j MAKE// deu bom
type2:
    slt $t2, $s2, $s5
    beq $t2, 1, TYPECOFE// DEU RUIM N TEM MILK TENTA DNV
    slt $t2, $s1, $s5
    beq $t2, 1, TYPECOFE// DEU RUIM N TEM CAFE TENTA DNV
    j MAKE// deu bom
type3:
    slt $t2, $s3, $s5
    beq $t2, 1, TYPECOFE// DEU RUIM N TEM MILK TENTA DNV
    slt $t2, $s1, $s5
    beq $t2, 1, TYPECOFE// DEU RUIM N TEM CAFE TENTA DNV
    j MAKE// deu bom

MAKE:
    beq $t3, 1, make1
    beq $t3, 1, make2
    beq $t3, 1, make3

make1:
    sub $s1, $s1, $s5
    
    j DIABETE
make2:
    sub $s1, $s1, $s5
    sub $s2, $s2, $s5// milk
    
    j DIABETE
make3:
    sub $s1, $s1, $s5
    sub $s3, $s3, $s5// chocolate
    
    j DIABETE

DIABETE:
    //ESPERA FAZER A PARADA N SEI ADICIONAR AINDA
    beq $t5, $zero, IMPRIME
    subi $s4, $s4, 1
    
    J IMPRIME

IMPRIME:
    // MOSTRAR RESULTADO,
    J TYPECOFE// RESETA MAQUINA
