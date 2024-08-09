.data
num:.word 0x0ffffffe
nummax:.word 0X0fffffff
.text
.global main
main:
	ldr r1,=num
	ldr r0,[r1]
	ldr r4, =nummax
	ldr r5,[r4]

	adds r0,#10
	mov r2,r0

	cmp r2,r5
	bgt fin
	mov r0,#0


fin:
	mov r7,#1
	swi 0

