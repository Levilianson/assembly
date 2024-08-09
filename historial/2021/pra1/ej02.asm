.data
N1:	.word 18
N2:	.word 33
N3:	.word 40
.text
.global main

main:
/*
obtener el resultado de N1 + N2 +N3
*/
	ldr r0, =N1	@carga en r0 la direccion de memoria de N1
	ldr r1,[r0]	@carga en r1 el contenido de N1 el valor 18

	ldr r2, =N2
	ldr r2,[r2]

	ldr r3, =N3
	ldr r3,[r3]

	add r0,r1,r2	@suma r1+r2

	sub r0,r3	@r0=N1+N2-N3
	@almecenar el resultado en N1

	ldr r6, =N1 @direccion de memoria
	str r0, [r6]	@se coloca en la posicion N1 el result de r0

	mov r7,#1
	swi #0

