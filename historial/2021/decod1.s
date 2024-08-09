.data
buffer:.space 100
texto: .ascii " "
longbuffer=.-buffer
.text
pantalla:
	@escribir lo leido
	.fnstart
	push {r7}

	mov r7, #4 @escribir
	mov r0, #1 @salida standar

	swi #0
	pop {r7}
	bx lr
	.fnend
indice:
	.fnstart
	@add r1,#1
	@ldrb r0,[r1]
	add r3,#3
	b continuar
	.fnend
	

.global main
main:
	@lectura teclado
	mov r7, #3 @lectura
	mov r0, #0 @entrada 
	@ldr r2, =longbuffer @leer caracteres 99
	mov r2, #99
	ldr r1, =buffer	@donde se guarda la cadena
	swi 0
	mov r3,#1
ciclo:
	ldrb r0,[r1]
	add r8,r0
	cmp r0,#' '
	beq continuar

	cmp r0,#','
	beq indice

comparo:
	cmp r0,#0
	beq fin

	add r5,r0,r3 @cambio el caracter
	strb r5,[r1]

continuar:
	add r1,#1
	b ciclo

fin:

	ldr r1,=buffer
	mov r2,#99

	 @cant bytes a escribir
	bl pantalla	
	mov r7,#1	
	swi #0

caracter:
	.fnstart
	add r5,r0,r2 @cambio el caracter
	strb r5,[r1]
	bx lr
	.fnend
