.data
 /* Definicion de datos */
mapa: .asciz "+------------------------------------------------+\n|               ****************                 |\n|               *** VIBORITA ***                 |\n|               ****************                 |\n+------------------------------------------------+\n|                                                |\n|                                                |\n|         @***                                   |\n|                                                |\n|                    M                           |\n|                                                |\n|                                                |\n|                                                |\n|                                                |\n+------------------------------------------------+\n| Puntaje:                      Nivel:           |\n+------------------------------------------------+\n"      @ \n enter
longitud = . - mapa
despedida: .asciz "\n Chau!\n"
longitud2 = . - despedida
.text    @ Defincion de codigo del programa
@ ------------ Código de la función
imprimirString:
      .fnstart
      mov r7, #4
  mov r0, #1
	swi 0    // SWI, Software interrup
      bx lr //salimos de la funcion mifuncion
      .fnend
.global main  @ global, visible en todo el programa
main:
 //llamamos a la subrutina para imprimir
           ldr r1, =mapa  // Cargamos en r1 la direccion del mensaje
           ldr r2, =longitud
           bl  imprimirString
           /*cambio el mapa, juego, llamo a otras partes del programa*/

           //llamamos a la subrutina para imprimir
           ldr r1, =despedida  // Cargamos en r1 la direccion del mensaje
           ldr r2, =longitud2 //Tamaño de la cadena
           bl  imprimirString
 mov r7, #1 // Salida al sistema
 swi 0
