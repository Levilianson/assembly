.data

.text
.global main
main:
	mov r1,#0
	mov r0,#1
ciclo:
	cmp r0,#100
	bhi fin

	add r1,r0
	add r0,#1
	b ciclo @salto sin condicional
fin:
	mov r7,#1
	swi #0
