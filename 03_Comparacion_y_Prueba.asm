; 03. Comparación y prueba
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Sirve para ver cómo reacciona el "cerebro" de la computadora (sus indicadores o "banderas") cuando hacemos diferentes 
;operaciones matemáticas o comparaciones. Nos muestra paso a paso qué pasa cuando un resultado da cero, cuando da
;negativo, cuando un número es demasiado grande y se desborda, o cuando solo queremos revisar cómo está formado un número por dentro.

.code 

; CASO 1: BANDERA DE CERO (Zero Flag - ZF) 
; Se enciende (ZF=1) si al comparar o hacer una operación el resultado es un cero exacto.
    main PROC 
    
    mov EBX , 1 ; Guardamos un 1 en EBX
    cmp ebx, 1 ; Comparamos 1 contra 1. Como son iguales, la resta interna da 0 y se enciende la bandera.
    call dumpRegs 

    mov EAX, 01h ; Guardamos un 1 en EAX
    cmp EAX, EBX ; Comparamos EAX (que vale 1) con EBX (que vale 1). Otra vez son iguales, da cero.
    call dumpRegs 

    mov cl, 1111111b ; Guardamos un número binario en CL
    cmp cl, cl ; Lo comparamos contra sí mismo. Obviamente da cero.
    call dumpRegs ; Mostramos cómo quedaron las banderas.

; CASO 2 : BANDERA DE SIGNO (Sign Flag - SF) 
; Se enciende (SF=1) si una operación matemática o comparación da como resultado un número negativo.
    mov Eax, 0 ; Limpiamos EAX
    mov EBX, 0 ; Limpiamos EBX

    mov al, -5 ; Guardamos un -5 en AL
    mov bl, 1  ; Guardamos un 1 en BL
    cmp al, bl ; Comparamos -5 contra 1 (hace -5 menos 1, que da -6). Como da negativo, se enciende la bandera.
    call dumpRegs ; Mostramos en pantalla que la bandera de signo se encendió.

; CASO 3 : BANDERA DE ACARREO (Carry Flag - CF) 
; Se enciende (CF=1) cuando nos pasamos del límite máximo al contar números normales (sin signo).
    mov EAX, 0 ; Limpiamos EAX
    mov EBX, 0 ; Limpiamos EBX

    mov al, 255 ; Guardamos 255, que es el número más grande que cabe en este pequeño espacio (AL).
    add al, 1 ; Le sumamos 1. Como ya no cabe (256), el espacio se desborda y se enciende la bandera.
    call dumpRegs ; Mostramos el desbordamiento en la pantalla.

; CASO 4 : BANDERA DE DESBORDAMIENTO (Overflow Flag - OF) 
; Se enciende (OF=1) cuando un número con signo (positivo o negativo) se sale de su límite permitido.
    mov EAX,0 ; Limpiamos EAX
    mov EBX, 0 ; Limpiamos EBX

    mov al, -128 ; Guardamos -128, que es el número negativo más grande que cabe aquí.
    mov bl, 1 ; Guardamos un 1.

    cmp al, bl ; Comparamos (-128 menos 1 da -129). Como -129 ya no cabe en este espacio, el programa se "tropieza" y enciende la bandera.
    call dumpRegs ; Mostramos en pantalla que hubo este error de límite.


; CASO 5 : PRUEBA (TEST) 
; Revisa el número por dentro (sus bits) sin cambiar el valor original, solo para encender banderas si es necesario.
    mov EAX, 0 ; Limpiamos EAX
    mov EAX, 5 ; Guardamos un 5 (que por dentro es 00000101)
    test EAX, 1 ; Revisa si el primer bit (el de la derecha) está encendido. 
    call dumpRegs ; Mostramos el resultado.

    mov EAX, 0 ; Limpiamos EAX
    mov al, 10000000b 
    test al, al ; Se revisa a sí mismo para ver si está en cero o si es negativo.
    call dumpRegs

exit 
main ENDP

END main
