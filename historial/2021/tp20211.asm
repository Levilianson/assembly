.data
codigo:.space 100
texto: .ascii " "
longcod=.-codigo
.text
pantalla:
	@escribir lo leido
	.fnstart
	mov r7, #4 @escribir
	mov r0, #1 @salida standar
	swi #0
	bx lr
	.fnend	

.global main
main:
	@lectura teclado
	mov r7, #3 @lectura
	mov r0, #0 @entrada 
	ldr r2,=longcod
	@mov r2, #99 @leer caracteres 99
	ldr r1, =codigo	@donde se guarda la cadena
	swi 0
	
ciclo:
	ldrb r0,[r1]
	cmp r0,#','
	beq indice	

	add r1,#1	
	b ciclo
indice:
	add r1,#1
	ldrb r0,[r1]
	add r3,r0,#-48
medio:
	add r1,#1
	ldrb r0,[r1]
	cmp r0,#','
	beq comparar
	
comparar:
	add r1,#1
	ldrb r0,[r1]
	
	cmp r0,#'c'
	beq codi
	cmp r0,#'d'
	beq deco
	
	
codi:
	ldr r1,=codigo
ciclo1:
	ldrb r0,[r1]
	cmp r0,#' '
	beq continuar
	cmp r0,#','
	beq borrar
	
	add r5,r0,r3 @cambio el caracter
	strb r5,[r1]
	
continuar:
	add r1,#1
	b ciclo1

deco:
	ldr r1,=codigo
	mov r4,#0
ciclo2:
	ldrb r0,[r1]
	cmp r0,#' '
	beq continuar2
	cmp r0,#','
	beq fin
	
	sub r5,r0,r3 @cambio el caracter
	strb r5,[r1]
	
continuar2:
	add r1,#1
	add r4,#1
	b ciclo2
borrar:
	mov r5,#' '
	strb r5,[r1]
	add r1,#1
	ldrb r0,[r1]
	cmp r0,#0
	beq fin
	b borrar
fin:		
	ldr r1,=codigo
	ldr r2, =longcod
	
	 @cant bytes a escribir
	bl pantalla
		
	mov r7,#1	
	swi #0

