.data
# Secci�n de datos para almacenar strings
message: .asciiz "\nIngrese un numero: "     # Mensaje para solicitar la entrada del usuario
fibSeries: .asciiz "Los primeros n n�meros de la serie de Fibonacci son: \n" # Mensaje inicial para la serie de Fibonacci
newline: .asciiz "\n"                        # String para un salto de l�nea

.text
.globl main
main:
    # Imprimir mensaje para ingresar n�mero
    li $v0, 4                   # Carga 4 en $v0 para la syscall de impresi�n de string
    la $a0, message             # Carga la direcci�n de 'message' en $a0
    syscall                     # Llama a la syscall para imprimir el mensaje

    # Leer n�mero del usuario
    li $v0, 5                   # Carga 5 en $v0 para la syscall de lectura de entero
    syscall                     # Llama a la syscall para leer el n�mero
    move $t0, $v0               # Mueve el n�mero le�do a $t0

    # Preparar para calcular la serie de Fibonacci
    li $t1, 0                   # Inicializa el primer n�mero de Fibonacci en $t1
    li $t2, 1                   # Inicializa el segundo n�mero de Fibonacci en $t2
    li $t3, 0                   # Inicializa el contador de t�rminos en $t3

    # Imprimir mensaje de la serie de Fibonacci
    li $v0, 4                   # Carga 4 en $v0 para la syscall de impresi�n de string
    la $a0, fibSeries           # Carga la direcci�n de 'fibSeries' en $a0
    syscall                     # Llama a la syscall para imprimir el mensaje

    # Bucle para calcular y mostrar la serie de Fibonacci
    loop:
        beq $t3, $t0, endloop   # Si el contador $t3 alcanza el n�mero ingresado $t0, sal del bucle

        # Imprimir el t�rmino actual de Fibonacci
        move $a0, $t1            # Mueve el t�rmino actual de Fibonacci a $a0
        li $v0, 1                # Carga 1 en $v0 para la syscall de impresi�n de entero
        syscall                  # Llama a la syscall para imprimir el n�mero

        # Imprimir un salto de l�nea
        li $v0, 4                # Carga 4 en $v0 para la syscall de impresi�n de string
        la $a0, newline          # Carga la direcci�n de 'newline' en $a0
        syscall                  # Llama a la syscall para imprimir el salto de l�nea

        # Calcular el siguiente t�rmino de la serie
        add $t4, $t1, $t2        # Suma los dos �ltimos t�rminos y almacena el resultado en $t4
        move $t1, $t2            # Prepara el pen�ltimo t�rmino para la siguiente iteraci�n
        move $t2, $t4            # Prepara el �ltimo t�rmino para la siguiente iteraci�n

        # Incrementar el contador
        addi $t3, $t3, 1         # Incrementa el contador de t�rminos

        j loop                   # Salta de nuevo al inicio del bucle

    endloop:
        # Finalizar el programa
        li $v0, 10               # Carga 10 en $v0 para la syscall de salida
        syscall                  # Llama a la syscall para terminar el programa
