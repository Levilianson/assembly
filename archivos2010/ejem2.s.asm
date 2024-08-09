.data
num_grand: .word 0x7fffffff

.text
.global main
main:
	mov r0,#1
	mov r1,#10
	mov r2,#200

	subs r3,r2,r1
	subs r4,r1,r2

	ldr r4, =num_grand
	ldr r5, [r4]

	neg r6,r5
	subs r7,r6,r5

	mov r7,#1
	swi #0
