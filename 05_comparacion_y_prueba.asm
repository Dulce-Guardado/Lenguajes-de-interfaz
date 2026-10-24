; 05- CONDICIONALES
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa para mostrar dos formas de repetir cosas (bucles), contando del 1 al 100 de ambas maneras.

.code
main PROC

; PRIMERA PARTE: EL BUCLE "WHILE" (Mientras)
; Revisa primero, actúa después.

    mov ebx, 1 ; Empezamos nuestro contador en 1.

cicloWhile: 

    cmp ebx, 100 ; Revisamos si nuestro contador ya llegó al 100.
    jg fin ; Si ya nos pasamos del 100, saltamos directo a la palabra "fin" para detenernos.

    mov eax, ebx ; Copiamos el número actual para poder imprimirlo.
    call WriteDec ; Lo mostramos en la pantalla.
    call Crlf 

    inc ebx ; Le sumamos 1 a nuestro contador (si era 1, ahora es 2).
    jmp cicloWhile ; Obligamos a la computadora a regresar a "cicloWhile" para repetir todo.

fin:
    call Crlf 

; SEGUNDA PARTE: EL BUCLE "DO-WHILE" (Hacer-Mientras)
; Actúa primero, revisa después.

    mov ebx, 1 ; Reiniciamos nuestro contador para volver a empezar desde el 1.

cicloDoWhile:

    mov eax, ebx ; Copiamos el número actual.
    call WriteDec ; Lo mostramos en la pantalla directamente (sin revisar nada antes).
    call Crlf

    inc ebx ; Le sumamos 1 a nuestro contador.
    
    cmp ebx, 100 ; Ahora sí, después de imprimir y sumar, revisamos si llegamos a 100.
    jle cicloDoWhile ; Si nuestro número es menor o igual a 100, regresamos a repetir el proceso.

    exit 
main ENDP

END main
