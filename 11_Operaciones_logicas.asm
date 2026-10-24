; 11.- Operaciones logicas 
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que muestra cómo usar operaciones lógicas (AND, OR, XOR, TEST)
; para encender, apagar y revisar bits específicos dentro de un número.

INCLUDE Irvine32.inc

; MAPA DE BITS (ESTADOS DEL SISTEMA):
; Bit 0 = Computadora encendida (0: No, 1: Si)
; Bit 1 = Estado de alarma      (0: No, 1: Si)
; Bit 2 = Conexion de corriente (0: No, 1: Si)
; Configuracion inicial: 00000101b (PC encendida, corriente conectada, alarma apagada)

.data
    msgEncendida BYTE "Alarma esta encendida", 0
    msgApagada BYTE "Alarma esta apagada", 0

.code
main PROC  

; CASO 1: AND (Aislar un bit)
    mov al, 00000101b
    and al, 00000010b   ; Apaga todos los bits excepto el Bit 1 (alarma) para ver solo su valor.

    call WriteBin       ; Imprime el resultado en binario (dará 00000000).

; CASO 2: OR (Encender un bit específico)
    mov eax, 0
    mov al, 00000101b
    or al, 00000010b    ; Enciende el Bit 1 (alarma) sin afectar el estado de los demás bits.

    call WriteBin       ; Imprime el resultado (dará 00000111).

; CASO 3: XOR (Apagar o invertir bits)
    mov eax, 0
    mov al, 00000101b
    xor al, 00000101b   ; Compara el número consigo mismo. Los bits iguales se vuelven 0, limpiando el registro.

    call WriteBin       ; Imprime el resultado (dará 00000000).
    call Crlf
    
; CASO 4: TEST (Revisar un bit sin alterarlo)
    mov al, 00000101b
    test al, 00000010b  ; Revisa si el Bit 1 (alarma) está encendido sin modificar el valor original en AL.
    jz alarmaApagada    ; Si el resultado es cero (el bit está apagado), salta a la etiqueta 'AlarmaApagada'.

    mov edx, OFFSET msgEncendida ; Si no saltó, carga el texto indicando que la alarma está encendida.
    call WriteString
    call Crlf
    jmp FinPrograma     ; Salta al final para evitar imprimir el segundo mensaje.

AlarmaApagada: 
    mov edx, OFFSET msgApagada ; Carga el texto indicando que la alarma está apagada.
    call WriteString
    call Crlf

FinPrograma:
    exit

main ENDP

END main
