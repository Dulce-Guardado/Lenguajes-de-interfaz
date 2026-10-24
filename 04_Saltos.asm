; 04- Saltos
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que demuestra el uso de saltos incondicionales (JMP) 
; para omitir la ejecución de una sección específica del código.

INCLUDE Irvine32.inc

.code
main PROC
    
    mov eax, 5      ; Asigna el valor 5 al registro EAX.

    jmp continuar   ; Ejecuta un salto incondicional hacia la etiqueta "continuar", omitiendo lo que hay debajo.
    
    mov eax, 10     ; Esta instrucción nunca se ejecuta debido al salto anterior. EAX conserva su valor de 5.

continuar:          ; Etiqueta de destino donde el flujo del programa se reanuda tras el salto.
    
    call DumpRegs   ; Imprime el estado de los registros en la consola para verificar que EAX sigue valiendo 5.

    exit            ; Finaliza la ejecución del programa.
main ENDP

END main
