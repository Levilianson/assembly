.data
max: .word 2096578
.text
.global main
main:
	ldr r1,=max
	ldr r1,[r1]
	mov r0,#1
ciclo:
	push {r2}
	add r0,#1

	cmp r0,r1
	beq fin
	b ciclo
fin:
	mov r7,#1
	swi 0
