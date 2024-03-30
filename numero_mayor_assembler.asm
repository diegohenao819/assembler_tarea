.data                           # Secci�n de datos
prompt: .asciiz "Ingrese un n�mero: "  # Mensaje para pedir n�mero
result: .asciiz "El n�mero mayor es: " # Mensaje para mostrar resultado

.text                           # Secci�n de c�digo
.globl main

main:
    # Inicializaci�n de variables
    li $t0, 0                   # Almacena el n�mero mayor
    li $t1, 3                   # Contador de n�meros a ingresar

input_loop:
    # Imprimir prompt
    li $v0, 4                   # syscall para print string
    la $a0, prompt              # carga la direcci�n del prompt
    syscall                     # imprime el prompt

    # Leer n�mero del usuario
    li $v0, 5                   # syscall para leer int
    syscall                     # lee el n�mero
    move $t2, $v0               # guarda el n�mero en $t2

    # Comparar y guardar si es mayor
    blt $t2, $t0, skip         # Si $t2 < $t0, salta a skip
    move $t0, $t2              # Guarda $t2 en $t0

skip:
    # Decrementar contador
    addi $t1, $t1, -1          # Decrementa $t1
    bgtz $t1, input_loop       # Si $t1 > 0, repite el loop

    # Imprimir resultado
    li $v0, 4                  # syscall para print string
    la $a0, result             # carga la direcci�n del mensaje resultado
    syscall                    # imprime el mensaje
    move $a0, $t0              # mueve el n�mero mayor a $a0
    li $v0, 1                  # syscall para print int
    syscall                    # imprime el n�mero mayor

    # Salir
    li $v0, 10                 # syscall para salir
    syscall                    # termina el programa
