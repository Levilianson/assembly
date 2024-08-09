
.model small ;define el modelo de segmentacion del programa
.stack 100h ; espacio de la pila del programa
.data   ; inicio de la seccion de datos del programa
    mensaje_nombre db 'nombre:', 0Dh, 0Ah, '$'; inicio de la linea 0Dh  y nueva linea 0Ah
    mensaje_identificacion db 'Identificacion: ', 0Dh, 0Ah,'$'
    nombre db 'Pomperik', 0Dh, 0Ah, '$'
    identificacion db '78946513', 0Dh, 0Ah, '$'
.code
main:
    mov ax, @data
    mov ds, ax

    mov ah, 09h ; mostrar un cadena
    lea dx, mensaje_nombre ; Direccion del mensaje
    int 21h     ; llamada al sistema DOS

    mov ah, 09h
    lea dx, nombre
    int 21h

    mov ah, 09h
    lea dx, mensaje_identificacion
    int 21h

    mov ah, 09h
    lea dx, identificacion
    int 21h

    mov ah, 4Ch ; termina el programa
    int 21h
end main