.data
codigo:.space 100
texto: .ascii "   \n"
longcod=.-codigo
mensaje: .ascii "\nIngrese Codigo:       "
longitud=.-mensaje
mensaje1: .ascii "El texto procesado:    "
longitud1=.-mensaje1
mensaje2: .ascii "Caracteres procesados: "
longitud2=.-mensaje2
.text
@calcular cant de letras
numeros:
	.fnstart
	push {lr}
	mov r1,r0
	mov r2,#10 @decenas
	bl division
	mov r2,r0 @resultado
	mov r0,r1 @modulo
	mov r3,r0 @unidad
	add r2,#48 @decenas
	add r3,#48 @centena
	pop {lr}
	.fnend

division:
	.fnstart
	mov r0,#0 @numero de iteraciones while
ciclod:
	cmp r1,r2
	bcc finciclo @a<b
	sub r1, r1,r2
	add r0,r0,#1
	b ciclod
finciclo:
	bx lr
	.fnend

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
teclado:
	mov r4,#0
	ldr r1,=mensaje
	ldr r2, =longitud
	bl pantalla
	@lectura teclado
	mov r7, #3 @lectura
	mov r0, #0 @entrada 
	ldr r2,=longcod
	ldr r1, =codigo	@donde se guarda la cadena
	swi 0
@ 1er recorrido	
ciclo:
	ldrb r0,[r1]
	cmp r0,#','
	beq coddec	

	add r1,#1	
	b ciclo
coddec:
	add r1,#1
	ldrb r0,[r1]
	cmp r0,#','
	beq comparar
	b coddec
	
comparar:
	add r1,#1
	ldrb r0,[r1]
	
	cmp r0,#'c'
	beq cindice
	cmp r0,#'d'
	beq deco
@---------------------------------
@@segundo recorrido	codificar

cindice:
	ldr r1,=codigo
cindi:
	add r1,#1
	ldrb r0,[r1]
	cmp r0,#','
	beq codf
	b cindi

codf:
	add r1,#1
	ldrb r0,[r1]
	add r3,r0,#-48 @valor de desplazamiento
		@tercer recorrido
codi:
	ldr r1,=codigo
	mov r4,#0 @contador
ciclo1:
	ldrb r0,[r1]
	cmp r0,#' '
	beq continuar
	
	cmp r0,#','
	beq borrar
	
	add r5,r0,r3 @cambio el caracter
	strb r5,[r1]
	add r4,#1
continuar:
	
	add r1,#1
	b ciclo1
@------------------------------
@segundo recorrido decodificar
deco:
	ldr r1,=codigo
bdeco:	
	add r1,#1
	ldrb r0,[r1]
	cmp r0,#','
	beq pista
	b bdeco

pista:
	add r1,#1
	mov r2,#02
	mov r3,#0
indec:	
	ldrb r0,[r1]
	cmp r0,#','
	beq decodificar
	add r1,#1
	and r6,r0,r2
	cmp r6,#0
	beq clet
	add r3,#1
	b indec
clet:
	add r3,#0
	b indec

decodificar:
	ldr r1,=codigo
	mov r4,#0
decosec:
	
	ldrb r0,[r1]
	cmp r0,#' '
	beq contdeco
	cmp r0,#','
	beq borrar
	
	sub r5,r0,r3 @cambio el caracter
	strb r5,[r1]
	add r4,#1
contdeco:
	add r1,#1	
	
	b decosec
borrar:
	mov r5,#' '
	strb r5,[r1]
	add r1,#1
	ldrb r0,[r1]
	cmp r0,#0
	beq fin
	b borrar
fin:		
	ldr r1,=mensaje1
	ldr r2, =longitud1
	bl pantalla
	ldr r1,=codigo
	ldr r2, =longcod
	bl pantalla
	ldr r1,=mensaje2
	ldr r2, =longitud2
	bl pantalla
	mov r0,r4
	bl numeros
	ldr r1,=texto
	strb r2,[r1]
	add r1,#1
	strb r3,[r1]
	ldr r1,=texto
	mov r2,#2
	bl pantalla
	
	bl teclado	
	mov r7,#1	
	swi #0
