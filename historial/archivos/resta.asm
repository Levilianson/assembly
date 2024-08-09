.data
num:.word 0x0ffffffe
nummax:.word 0X0fffffff
.text
.global main
main:
	ldr r1,=num
	ldr r3,[r1]
	ldr r4, =nummax
	ldr r5,[r4]
	neg r0,r3

	subs r6,r0,r3
	mov r2,r6

	cmn r2,r0
	blt fin
	mov r0,#0


fin:
	mov r7,#1
	swi 0


