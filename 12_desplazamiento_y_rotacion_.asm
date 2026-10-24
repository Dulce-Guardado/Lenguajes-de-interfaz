; 12.- Desplazamiento y Rotacion
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que muestra el uso de desplazamientos y rotaciones de bits 
; (SHL, SHR, SAR, ROR, ROL) para modificar datos a nivel binario.

INCLUDE Irvine32.inc

.code
main PROC  

    ; Limpiamos los registros principales poniéndolos en cero
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

; 1 SHL: Desplazamiento a la izquierda
    mov al, 10000110b
    shl al, 1       ; Mueve los bits un espacio a la izquierda (rellena con un cero a la derecha). Esto equivale a multiplicar por 2.

    call DumpRegs
    call WriteBin
    
; 2 SHR: Desplazamiento a la derecha
    mov al, 00001101b
    shr al, 1       ; Mueve los bits un espacio a la derecha (rellena con un cero a la izquierda). Equivale a dividir entre 2.

    call DumpRegs
    call WriteBin

; 3 SAR: Desplazamiento a la derecha conservando el signo (con número negativo par)
    mov eax, 0
    mov al, -8
    sar al, 1       ; Mueve los bits a la derecha, pero copia el bit de signo a la izquierda para que el número siga siendo negativo.

    call DumpRegs
    call WriteBin

; 4 SAR: Desplazamiento a la derecha conservando el signo (con número negativo impar)
    mov eax, 0
    mov al, -9
    sar al, 1       ; Mismo desplazamiento, manteniendo el signo negativo.

; 5 Desplazamiento usando un número directo mayor a 1
    mov al, 00001100b
    shl al, 2       ; Mueve los bits dos posiciones a la izquierda en una sola instrucción.

    call DumpRegs
    call WriteBin

; 6 Desplazamiento usando un registro para indicar la cantidad de espacios
    mov al, 00001100b
    mov cl, 2       ; Guardamos un 2 en CL.
    shr al, cl      ; Mueve a la derecha la cantidad de espacios que indica CL (2 espacios).

; 7 ROTACIONES CIRCULARES (Los bits no se pierden, dan la vuelta)

; ROR: Rotación hacia la derecha
    mov al, 10000001b
    ror al, 1       ; Mueve los bits a la derecha. El bit que sale por la derecha vuelve a entrar por la izquierda.

    call DumpRegs
    call WriteBin

; ROL: Rotación hacia la izquierda
    mov al, 10000001b
    rol al, 1       ; Mueve los bits a la izquierda. El bit que sale por la izquierda vuelve a entrar por la derecha.

    call DumpRegs
    call WriteBin

    exit

main ENDP

END main

