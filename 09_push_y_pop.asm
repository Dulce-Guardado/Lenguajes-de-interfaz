; 09.- PUSH y POP
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que demuestra el uso de la pila para guardar y recuperar valores, 
; el orden LIFO (último en entrar, primero en salir) y la ejecución de subrutinas.

INCLUDE Irvine32.inc

.code
main PROC  
    ; SECCIÓN 1: Práctica básica de apilado y desapilado
    mov eax, 40
    push eax        ; Guardamos el valor 40 en el tope de la pila

    nop

    mov eax, 0      ; Sobrescribimos EAX con 0
    pop ebx         ; Extraemos el 40 de la pila y lo guardamos en EBX

    nop

    ; SECCIÓN 2: Demostración de la regla LIFO (Último en entrar, Primero en salir)
    mov eax, 10
    push eax        ; Apilamos el 10

    mov eax, 20
    push eax        ; Apilamos el 20

    mov eax, 30
    push eax        ; Apilamos el 30

    pop eax         ; Desapilamos el último valor que ingresó (30) hacia EAX
    pop ebx         ; Desapilamos el valor anterior (20) hacia EBX
    pop ecx         ; Desapilamos el primer valor que ingresó (10) hacia ECX

    nop

    ; SECCIÓN 3: Resguardo temporal de registros en la pila
    mov eax, 100
    mov ebx, 200

    push eax        ; Respaldamos el valor de EAX (100) en la pila
    push bx         ; Respaldamos la mitad inferior del registro EBX
    push ebx        ; Respaldamos el valor completo de EBX (200)

    mov eax, 999    ; Modificamos EAX sin perder su valor original guardado en la pila
    mov ebx, 666    ; Modificamos EBX sin perder su valor original

    nop

    ; SECCIÓN 4: Invocación de subrutinas mediante CALL y RET
    mov eax, 50
    mov ebx, 100

    call aumentarDiez ; Detiene la ejecución aquí, va a la subrutina y regresa cuando termina
    
    nop
    exit
main ENDP

aumentarDiez PROC ; Subrutina que suma 10 al registro EAX
    push ebx        ; Respaldamos el valor original de EBX en la pila antes de usarlo

    mov ebx, 10 
    add eax, ebx    ; Sumamos el 10 a EAX

    pop ebx         ; Recuperamos de la pila el valor original de EBX

    ret             ; Termina la subrutina y regresa al bloque de código principal
aumentarDiez ENDP

END main
