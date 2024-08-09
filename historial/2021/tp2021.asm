.data
buffer:.space 100
texto: .ascii " "
longbuffer=.-buffer
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
	@ ldr r2,=buffer
	mov r2, #99 @leer caracteres 99
	ldr r1, =buffer	@donde se guarda la cadena
	swi 0
	
ciclo:
	
	ldrb r0,[r1]
	cmp r0,#'0'
	beq fin	

	add r1,#1	
	b ciclo

	
	
fin:	

	
	ldr r1,[=buffer,#60]
	mov r2, #99
	
	 @cant bytes a escribir
	bl pantalla	
	mov r7,#1	
	swi #0

