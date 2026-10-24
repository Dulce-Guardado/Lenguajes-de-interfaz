; 6.1: Control de ocupación de un estacionamiento.
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que controla los espacios de un estacionamiento con capacidad para 20 autos,
; sumando los autos que entran y mostrando cuántos lugares quedan disponibles o si ya se llenó.

INCLUDE Irvine32.inc

.data
    msgEntrada BYTE "Ingrese cantidad de autos ",0
    msgOcupados BYTE "Espacios ocupados ",0
    msgDisponibles BYTE "Espacios disponibles ",0
    msgLleno BYTE "Estacionamiento lleno",0
    msgExceso BYTE "No hay suficientes espacios disponibles",0
    msgInvalido BYTE "Cantidad invalida",0

    capacidad = 20      ; Límite máximo de lugares permitidos
    ocupados DWORD 0    ; Contador que lleva el registro de los lugares usados actualmente

.code
main PROC
ingresar:
    ; Pedimos al usuario que escriba cuántos autos van a entrar
    mov edx, OFFSET msgEntrada
    call WriteString
    call ReadInt        ; Leemos el número ingresado y lo guardamos en EAX

    ; Verificamos que el número sea válido (mayor a cero)
    cmp eax, 0
    jle invalido        ; Si es cero o un número negativo, salta a mostrar el error de cantidad inválida

    mov ebx, eax        ; Guardamos el número de autos nuevos en EBX temporalmente

    ; Calculamos el total sumando los autos nuevos a los que ya estaban estacionados
    mov eax, ocupados
    add eax, ebx

    ; Revisamos si con esta entrada superamos el límite de 20 lugares
    cmp eax, capacidad
    jg exceso           ; Si el total es mayor a la capacidad, salta al mensaje de exceso

    mov ocupados, eax   ; Si el número está dentro del límite, actualizamos el contador oficial de ocupados

    ; Mostramos en pantalla el total de espacios ocupados
    mov edx, OFFSET msgOcupados
    call WriteString
    mov eax, ocupados
    call WriteDec
    call Crlf

    ; Revisamos si el estacionamiento se llenó por completo en este turno
    mov eax, ocupados
    cmp eax, capacidad
    je lleno            ; Si los ocupados son exactamente iguales a la capacidad, salta al mensaje de lleno

    ; Si aún hay espacio, calculamos y mostramos cuántos lugares quedan libres
    mov edx, OFFSET msgDisponibles
    call WriteString
    mov eax, capacidad
    sub eax, ocupados   ; Restamos: capacidad total menos lugares ocupados
    call WriteDec
    call Crlf
    call Crlf

    jmp ingresar        ; Regresamos al inicio para registrar la siguiente entrada de autos

exceso: 
    ; Muestra que no hay espacio suficiente para la cantidad solicitada y vuelve a preguntar
    mov edx, OFFSET msgExceso
    call WriteString
    call Crlf
    call Crlf
    jmp ingresar

invalido: 
    ; Muestra que el número ingresado no es válido (ej. un 0) y vuelve a preguntar
    mov edx, OFFSET msgInvalido
    call WriteString
    call Crlf
    call Crlf
    jmp ingresar

lleno: 
    ; Muestra que el estacionamiento llegó a su límite máximo y termina el ciclo
    mov edx, OFFSET msgLleno
    call WriteString
    call Crlf

fin:
    exit              

main ENDP

END main
