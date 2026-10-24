; 03. Comparación y prueba
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que demuestra cómo las operaciones aritméticas y de comparación 
; afectan las banderas de estado del procesador (ZF, SF, CF, OF).

.code 

; CASO 1: BANDERA DE CERO (Zero Flag - ZF) 
; Se activa (ZF=1) cuando el resultado de una operación matemática o comparación es cero.
main PROC 
    
    mov EBX , 1     ; Asigna el valor 1 al registro EBX
    cmp ebx, 1      ; Compara EBX (1) con 1. La resta interna da 0, lo que activa la bandera ZF.
    call dumpRegs   ; Imprime el estado actual de los registros y banderas en la consola.

    mov EAX, 01h    ; Asigna el valor 1 en hexadecimal a EAX
    cmp EAX, EBX    ; Compara EAX (1) con EBX (1). El resultado es 0, activando ZF.
    call dumpRegs   

    mov cl, 1111111b; Asigna un valor binario al registro CL
    cmp cl, cl      ; Compara CL consigo mismo. La resta interna da 0, activando ZF.
    call dumpRegs   

; CASO 2: BANDERA DE SIGNO (Sign Flag - SF) 
; Se activa (SF=1) cuando el resultado de una operación es un número negativo.
    mov Eax, 0      ; Limpia el registro EAX
    mov EBX, 0      ; Limpia el registro EBX

    mov al, -5      ; Asigna el valor -5 al registro AL
    mov bl, 1       ; Asigna el valor 1 al registro BL
    cmp al, bl      ; Resta internamente 1 a -5. El resultado es -6 (negativo), activando SF.
    call dumpRegs   

; CASO 3: BANDERA DE ACARREO (Carry Flag - CF) 
; Se activa (CF=1) cuando ocurre un desbordamiento al trabajar con números sin signo.
    mov EAX, 0      ; Limpia EAX
    mov EBX, 0      ; Limpia EBX

    mov al, 255     ; Asigna 255 a AL (el valor máximo sin signo que cabe en 8 bits).
    add al, 1       ; Suma 1 a 255. El resultado (256) excede el límite de 8 bits, activando CF.
    call dumpRegs   

; CASO 4: BANDERA DE DESBORDAMIENTO (Overflow Flag - OF) 
; Se activa (OF=1) cuando ocurre un desbordamiento al trabajar con números con signo.
    mov EAX,0       ; Limpia EAX
    mov EBX, 0      ; Limpia EBX

    mov al, -128    ; Asigna -128 a AL (el valor mínimo negativo que cabe en 8 bits).
    mov bl, 1       ; Asigna 1 a BL.

    cmp al, bl      ; Resta internamente 1 a -128. El resultado (-129) excede el límite inferior de 8 bits, activando OF.
    call dumpRegs   


; CASO 5: PRUEBA LÓGICA (TEST) 
; Realiza una operación AND lógica bit a bit para actualizar las banderas sin modificar el valor original.
    mov EAX, 0      ; Limpia EAX
    mov EAX, 5      ; Asigna 5 (00000101 en binario) a EAX.
    test EAX, 1     ; Evalúa si el primer bit de la derecha está encendido haciendo un AND con 1.
    call dumpRegs   

    mov EAX, 0      ; Limpia EAX
    mov al, 10000000b ; Asigna a AL un valor que tiene el bit más significativo (el del signo) encendido.
    test al, al     ; Evalúa el número consigo mismo. Al tener el bit de signo encendido, activa la bandera SF.
    call dumpRegs

exit 
main ENDP

END main
