.data                           # Sección de datos
prompt: .asciiz "Ingrese un número: "  # Mensaje para pedir número
result: .asciiz "El número mayor es: " # Mensaje para mostrar resultado

.text                           # Sección de código
.globl main

main:
    # Inicialización de variables
    li $t0, 0                   # Almacena el número mayor
    li $t1, 3                   # Contador de números a ingresar

input_loop:
    # Imprimir prompt
    li $v0, 4                   # syscall para print string
    la $a0, prompt              # carga la dirección del prompt
    syscall                     # imprime el prompt

    # Leer número del usuario
    li $v0, 5                   # syscall para leer int
    syscall                     # lee el número
    move $t2, $v0               # guarda el número en $t2

    # Comparar y guardar si es mayor
    blt $t2, $t0, skip         # Si $t2 < $t0, salta a skip
    move $t0, $t2              # Guarda $t2 en $t0

skip:
    # Decrementar contador
    addi $t1, $t1, -1          # Decrementa $t1
    bgtz $t1, input_loop       # Si $t1 > 0, repite el loop

    # Imprimir resultado
    li $v0, 4                  # syscall para print string
    la $a0, result             # carga la dirección del mensaje resultado
    syscall                    # imprime el mensaje
    move $a0, $t0              # mueve el número mayor a $a0
    li $v0, 1                  # syscall para print int
    syscall                    # imprime el número mayor

    # Salir
    li $v0, 10                 # syscall para salir
    syscall                    # termina el programa
