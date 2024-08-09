.data
 /* Definicion de datos */
mapa: .asciz "+------------------------------------------------+\n|             ****************      |\n|        *** VIBORITA ***          |\n|         ****************        /*  |\n+------------------------------------------------+\n|                |\n|                   |\n|         @***      |\n|                                 |\n|    M                               |\n|                        |\n|                           |\n|              |\n|                           |\n+------------------------------------------------+\n| Puntaje:      Nivel:           |\n+------------------------------------------------+\n" */     @ \n enter
longitud=.-mapa
fin: .asciz "                   Game Over                       \n"
longitud2=.-fin
mensaje: .ascii "Ingresá direccion:\n"
longitud3=.-mensaje
letraDireccion: .ascii" "
posicionActual: .ascii"                  "

.text 			@ Defincion de codigo del programa
@--------Codigo de la funcion
imprimirString:
	.fnstart
	@parametros inputs:
	@r1=puntero al string que queremos imprimir
	@r2=longitud de lo que queremos imprimir
	mov r7,#4	@salida por pantalla
	mov r0,#1	@indicamos a SWI que sera una cadena
	swi 0		@software interrup
	bx lr		@salimos de la funcion
	.fnend

leerString:	@leerTecla
	.fnstart
	@Leer el input del usuario

	mov r7, #3 	@Lectura por teclado
	mov r0, #0	@Ingreso de cadena
	mov r2, #4	@Leer caracteres
	ldr r1,=letraDireccion	@guardo la tecla ingresada

	swi 0		@software interrup
	bx lr		@salimos de la funcion
	.fnend

escribir:
	.fnstart
	@Parametros inputs r0=columna r8=fila r2=char

	ldr r3,=mapa	@puntero al mapa
			@calculamos el indice a la fila
	mov r4,#51
	mul r4, r8,r4	@r4 numero de fila*tamaño de la fila
	add r3,r4	@puntero a la fila indicada en r0
			@despazarme hasta la columna correcta
	add r3,r0	@r3 puntero a fila + columna
	strb r2,[r3]	@guardo el char en la posicion de r3
	bx lr		@volvemos a donde nos llamaron
	.fnend

moverViborita:
	.fnstart
	push {r1}
	ldr r1,=letraDireccion
	cmp r1,#115
	beq abajo
	cmp r1,#119	@comparo la tecla ingresada
	beq arriba
	pop {r1}
	bx lr
	.fnend

abajo:
	.fnstart
	ldr r8,=posicionActual
	add r8,#51
	strb r8,[r8]
	bl escribir

	bx lr
	.fnend
arriba:
	.fnstart
	ldr r8,=posicionActual
	sub r8,#51
	bl escribir

	bx lr
	.fnend


.global main		@ global, visible en todo el programa

main:
	@Llamamos a la subrutina para imprimir
	ldr r1,=mapa
	ldr r2,=longitud
       	bl imprimirString

	ldr r1,=mensaje
	ldr r2,=longitud3
	bl imprimirString
	bl leerString


	bl moverViborita
	bl escribir


	mov r2,#64	@char
	mov r0,#10	@columna
	mov r8,#8	@fila
	ldr r2,=posicionActual
	bl escribir
	ldr r1,=mapa
	ldr r2,=longitud
	bl imprimirString



	mov r2,#64
	mov r0,#10
	mov r8,#6
	bl escribir
	ldr r1,=mapa
	ldr r2,=longitud
	bl imprimirString




	ldr r1,=fin
	ldr r2,=longitud2
	bl imprimirString
salir:

	mov r7, #1	@ Salida al sistema
	swi 0

