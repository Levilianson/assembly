.data
.text

.global main
main:
	mov r0,#10
	b continuar	@salta a continurar

	@esto nunca se ejecuta
	add r0, #100
continuar:
	sub r0,#1

	cmp r0,#0
	bne continuar	@se resta hasta r0 =0

	mov r1,#-5
	@si r1 ==0 le sumo 1 sino resto
	cmp r1,#0
	bne sumar

	sub r1,#1
	b fin
sumar:
	add r1,#1
fin:
	mov r7,#1
	swi #0
