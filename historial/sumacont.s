@suma de un word de mas numeros vector con una comparacion
.data
vector: .word 1,2,3,4
cantidad:.word 6
.text
.global main
main:
	mov r0,#0
	mov r3,#0
	ldr r2,=vector

	ldr r5,=cantidad @le cargo la cantidad de la palabra
	ldr r5,[r5]
ciclo:
	ldr r4,[r2]	@obtengo la direccion de memoria que se incremente 
			@ en suma

	cmp r3,r5	@comparo con el valor cargado sirve par iterar
	beq fin
sum:
	add r0,r4	@suma valores en r0
	add r2,#4	@me muevo al siguiente elemento 1word 4bytes.
	add r3,#1	@controlo el size
	b ciclo
fin:
	mov r7,#1
	swi #0

