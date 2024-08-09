.data
.text
.global main
main:	
	mov r1,#4
	mov r0,#5
	add r1,r1,r0

fin:
	mov r7,#1
	swi 0
