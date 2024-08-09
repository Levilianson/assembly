.data
puntos: .word 123
texto:.ascii"     "
.text
convertir:
.fnstart
push {lr}
mov r1, r0    @r1=A
mov r2, #100  @r2=B
bl division   @r0= A/B, r1=resto(A/B)
mov r3, r0    @r3 = r0/100 @en r3 tenemos las centenas  
              @r3= las centenas: 1 (000...00001)
 
mov r0, r1  @ r0 = resto(r0/100)
mov r1, r0    @r1=A
mov r2, #10  @r2=B
bl division   @r0= A/B, r1=resto(A/B)
mov r2, r0    @r2 = r0/10 @en r2 tenemos las decenas  

mov r0, r1 @r0 = resto(r0/10)

mov r1, r0

@Imprimir en pantalla cada peso @mapear cada peso a su correspondiente codigo ascii 
              @r1=r1+48 =3 + 48 = 51  @obtenemos el codigo ascci del 3
add r1, #48 @codigo ascii de las unidades
              @r2=r2+48 =2 + 48 = 50 
add r2,#48 @codigo ascii de las decenas
              @r3=r3+48 =1 + 48 = 49   
add r3, #48 @codigo ascii de las centeas

pop {lr}
bx lr @volvemos a donde nos llamaron
.fnend

division: @ dividimos A/B
.fnstart
@input: 
@r1 = A, r2 = B
@output:
@r0= A/B, r1=resto(A/B)
@   C = 0
 mov r0, #0 @en r0 vamos a contar cuantas veces entra B en A, es decir, r0 contentrá la división A/B
@   while( A >= B )
ciclo:
     cmp r1, r2
     bcc  finCiclo  @si A<B

     sub r1, r1, r2  @        A = A - B

     add r0, r0, #1 @        C = C + 1

           b ciclo
finCiclo:
        @ r0=la division A/B , lo guardamos en la memoria C
               @en r1      quedaria el resto
       bx lr @volvemos a donde nos llamaron
.fnend
@----------------------------------------------------------
.global main 
main:
     mov r0, #44
     @ldr r0, [r0] @r0 = #123

     bl convertir
	mov r0,#0
	ldr r1,=texto
	strb r2,[r1]
	add r1,#1
	strb r2,[r1]
	add r1,#1
	strb r3,[r1]
	mov r7,#4
	mov r0,#1
	mov r2,#99
	ldr r1,=texto
	swi 0


     
mov r7, #1    @ Salida al sistema
swi 0
