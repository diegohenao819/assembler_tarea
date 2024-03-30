.data
# Sección de datos para almacenar strings
message: .asciiz "\nIngrese un numero: "     # Mensaje para solicitar la entrada del usuario
fibSeries: .asciiz "Los primeros n números de la serie de Fibonacci son: \n" # Mensaje inicial para la serie de Fibonacci
newline: .asciiz "\n"                        # String para un salto de línea

.text
.globl main
main:
    # Imprimir mensaje para ingresar número
    li $v0, 4                   # Carga 4 en $v0 para la syscall de impresión de string
    la $a0, message             # Carga la dirección de 'message' en $a0
    syscall                     # Llama a la syscall para imprimir el mensaje

    # Leer número del usuario
    li $v0, 5                   # Carga 5 en $v0 para la syscall de lectura de entero
    syscall                     # Llama a la syscall para leer el número
    move $t0, $v0               # Mueve el número leído a $t0

    # Preparar para calcular la serie de Fibonacci
    li $t1, 0                   # Inicializa el primer número de Fibonacci en $t1
    li $t2, 1                   # Inicializa el segundo número de Fibonacci en $t2
    li $t3, 0                   # Inicializa el contador de términos en $t3

    # Imprimir mensaje de la serie de Fibonacci
    li $v0, 4                   # Carga 4 en $v0 para la syscall de impresión de string
    la $a0, fibSeries           # Carga la dirección de 'fibSeries' en $a0
    syscall                     # Llama a la syscall para imprimir el mensaje

    # Bucle para calcular y mostrar la serie de Fibonacci
    loop:
        beq $t3, $t0, endloop   # Si el contador $t3 alcanza el número ingresado $t0, sal del bucle

        # Imprimir el término actual de Fibonacci
        move $a0, $t1            # Mueve el término actual de Fibonacci a $a0
        li $v0, 1                # Carga 1 en $v0 para la syscall de impresión de entero
        syscall                  # Llama a la syscall para imprimir el número

        # Imprimir un salto de línea
        li $v0, 4                # Carga 4 en $v0 para la syscall de impresión de string
        la $a0, newline          # Carga la dirección de 'newline' en $a0
        syscall                  # Llama a la syscall para imprimir el salto de línea

        # Calcular el siguiente término de la serie
        add $t4, $t1, $t2        # Suma los dos últimos términos y almacena el resultado en $t4
        move $t1, $t2            # Prepara el penúltimo término para la siguiente iteración
        move $t2, $t4            # Prepara el último término para la siguiente iteración

        # Incrementar el contador
        addi $t3, $t3, 1         # Incrementa el contador de términos

        j loop                   # Salta de nuevo al inicio del bucle

    endloop:
        # Finalizar el programa
        li $v0, 10               # Carga 10 en $v0 para la syscall de salida
        syscall                  # Llama a la syscall para terminar el programa
