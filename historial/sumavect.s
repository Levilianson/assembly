@suma de un word de 4 numeros vector
.data
vector: .word 1,2,3,4
.text
.global main
main:
	mov r0,#0
	mov r3,#0
	ldr r2,=vector
ciclo:
	ldr r4,[r2]	@obtengo la direccion de memoria que se incremente 
			@ en suma
	cmp r3,#4	@comparo el size del vactor
	beq fin
sum:
	add r0,r4	@suma valores en r0
	add r2,#4	@me muevo al siguiente elemento 1word 4bytes.
	add r3,#1	@controlo el size
	b ciclo
fin:
	mov r7,#1
	swi #0

