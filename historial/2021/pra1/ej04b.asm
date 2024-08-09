.data
vecto1:	.word 128, 314, 1024, 127, 16000, 65000
.text
.global main

main:
/*
obtener el resultado de N1 + N2 +N3
*/
	ldr r0, =vecto1	@carga en r0 el vecto1 entero
	ldr r1,[r0]	@carga en r2 el contenido del primer lugar

	add r0,#4	@me paso a otro lugar del vector
	ldr r2,[r0]	@se carga el segundo valor
	add r1, r2	@suma de r1+r2

	add r0,#4
	ldr r2,[r0]
	add r1,r2

	add r0,#4
	ldr r2,[r0]
	add r1,r2

	add r0,#4
	ldr r2,[r0]
	add r1,r2

	add r0,#4
	ldr r2,[r0]
	add r1,r2

/*	ldr r3, =N3
	ldr r3,[r3]

	add r0,r1,r2	@suma r1+r2

	sub r0,r3	@r0=N1+N2-N3
	@almecenar el resultado en N1

	ldr r6, =N1 @direccion de memoria
	str r0, [r6]	@se coloca en la posicion N1 el result de r0
*/
	mov r7,#1
	swi #0

