.data
.text
.global main
main:
	mov r0,#0
ciclo:
	push {r1}
	add r0,#1
	b ciclo
fin:
	mov r7,#1
	swi 0
