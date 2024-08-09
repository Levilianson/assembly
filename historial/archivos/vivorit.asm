.data
/* Definicion de datos*/
.mapa: .asciz "+----------------------------+\n|	   *****************
|\n|	***VIBORITA***		|\n|	**************
|\n+----------------------------+\n|			|\n|
|\n|	@***		|\n|			|\n|
|\n|		|\n|			|\n|
|\n|			|\n|
|\n+--------------------------------+\n|Puntaje:		Nivel:
|\n+-------------------------------+\n"	@\n enter

longitud= .-mapa
despedida: .asciz"\nChau!\n"
longitud2= .-despedida
.text
.global main
main:
	mov r7, #4
	mov r0, #1

	ldr r2, =longitud
	ldr r1, =mapa
	swi 0

	mov r7, #1
	swi 0
