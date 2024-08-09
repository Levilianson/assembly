.data
.text
.global main
main:
            mov r0, #0        @ inicializar en cero el registro resultado
    	mov r1, #1            @ R1 <-- 1
            mov r2, #2        @ R2 <-- 2
            mov r3, #3        @ R3 <-- 3
            mov r4, #4        @ R4 <-- 4
            add r5, r1, r2    @ R5 <-- 1 + 2 = 3
            add r6, r3, r4    @ R5 <-- 3 + 4 = 7
            add r0, r5, r6    @ R0 <-- 3 + 7 = 10

fin:
	mov r7, #1	      @ Salida al sistema
	swi 0

