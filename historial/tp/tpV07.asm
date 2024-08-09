


.data
 /* Definicion de datos */
mapa: .asciz "+------------------------------------------------+\n|               ****************                 |\n|               *** VIBORITA ***                 |\n|               ****************                 |\n+------------------------------------------------+\n|                                                |\n|                                                |\n|         @***                                   |\n|                                                |\n|M                                               |\n|                                                |\n|                                                |\n|                                                |\n|                                                |\n+------------------------------------------------+\n| Puntaje:                      Nivel:           |\n+------------------------------------------------+\n"      @ \n enter
longitud=.-mapa
fin: .asciz "                   Game Over                       \n"
longitud2=.-fin
mensaje: .ascii "Ingrese direcciÃ³n:\n"
longitud3=.-mensaje
letraDireccion: .ascii" "
posicionActual: .ascii"                  "
filaSer: .word 10
colSer: .word 7
cantCol: .word 51
errar: .ascii "Ingrese una direcciÃ³n valida"
longitud4=.-errar


.text 			@ Defincion de codigo del programa

									@NOTAS EDITACION EMI
									@ SOLO DEJE UN ESCRIBIR EN EL MAIN Y ARREGLO LA
									@ MALA ESCRITURA; QUE SE MOVIERA EL MAPA; QUE SE HAGA DOBLE
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
	mov r2, #1	@Leer caracteres
	ldr r1,=letraDireccion	@guardo la tecla ingresada

	swi 0		@software interrup
	bx lr		@salimos de la funcion
	.fnend

abajo:
	.fnstart
	push {lr}
	bl escribirCuerpo
	pop {lr}
	add r8,#1
	push {lr}
	bl escribir
	pop {lr}
	bx lr

	.fnend

arriba:
	.fnstart
	push {lr}
	bl escribirCuerpo
	pop {lr}
	sub r8,#1
	push {lr}
	bl escribir
	pop {lr}
	bx lr

	.fnend
derecha:
	.fnstart
	push {lr}
	bl escribirCuerpo
	pop {lr}
	add r6,#1
	push {lr}
	bl escribir
	pop {lr}
	bx lr

	.fnend
izquierda:
	.fnstart
	push {lr}
	bl escribirCuerpo
	pop {lr}
	sub r6, #1				@R6 es la columna
	push {lr}
	bl escribir
	pop {lr}
	bx lr

	.fnend
error:
	.fnstart
	ldr r1,=errar
	ldr r2,=longitud4
	bx lr
	.fnend


escribir:
	.fnstart
	@Parametros inputs r0=columna r8=fila r2=char

	ldr r3,=mapa	@puntero al mapa
	mov r2, #'@'

	ldr r4, =cantCol
	ldr r4, [r4]		@calculamos el indice a la fila
	mov r4, #51
	mul r4, r8,r4	@r4 numero de fila*tamaño de la fila
	add r3,r4	@puntero a la fila indicada en r0
			@despazarme hasta la columna correcta
	add r3,r6	@r3 puntero a fila + columna
	strb r2,[r3]	@guardo el char en la posicion de r3
	@sub r3,#51								@volver posicion antes qe se mueva
	@strb r9,[r3]								@dibuja el asterisco
	bx lr		@volvemos a donde nos llamaron
	.fnend

escribirCuerpo:
	.fnstart
	@Parametros inputs r0=columna r8=fila r2=char

	ldr r3,=mapa	@puntero al mapa
	mov r2, #'*'
	ldr r4, =cantCol
	ldr r4, [r4]		@calculamos el indice a la fila
	mov r4, #51
	mul r4, r8,r4	@r4 numero de fila*tamaño de la fila
	add r3,r4	@puntero a la fila indicada en r0
			@despazarme hasta la columna correcta
	add r3,r6	@r3 puntero a fila + columna
	strb r2,[r3]								@dibuja el asterisco
	bx lr		@volvemos a donde nos llamaron
	.fnend


moverViborita: @no me tomo ninfuna instruccion
	.fnstart
	push {r5}

	cmp r5,#'a'
	beq izquierda

	cmp r5,#'d'
	beq derecha	@comparo la tecla ingresada

	cmp r5,#'w'
	beq arriba

	cmp r5,#'s'
	beq abajo

	blt error	@si ingresa cualquier otra tecla envia un mesaje de error

	pop {r9}
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

	ldr r6, =filaSer
	ldr r6, [r6]
	ldr r8, =colSer
	ldr r8, [r8]

@	ldr r10,=posicionActual
@	ldr r3,[r10]
	cmp r6,#'-'		@comparo el dato de la posicion con "-"si es igual pierde
	beq salir
	cmp r6,#'|'		@comparo el dato de la posicion con"|"si es igual pierde
	beq salir


ciclo:
@1	bl imprimirString
	bl leerString

	ldr r5,=letraDireccion
	ldrb r5,[r5]
	bl moverViborita			@e2liminado	
	@bl escribir				eliminado


@up:
	@mov r2,#64  				@dibuja el@		eliminado, ya lo puse en una rutina	
	@mov r9,#42				@Dibuja el asterisco	eliminado, ya lo puse en una rutina
	@bl posAnterior
	@2    bl moverViborita
	@bl escribir							eliminado, ya lo puse en una rutina


	ldr r1,=mapa
	ldr r2,=longitud
	bl imprimirString
	bl ciclo  @loop solo termina haciendo crl+1


salir:
	ldr r1,=fin
	ldr r2,=longitud2
	bl imprimirString
	mov r7, #1	@ Salida al sistema
	swi 0


