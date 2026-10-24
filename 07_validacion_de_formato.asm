;7.- VALIDACION DE FORMATOS
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que revisa si un texto ingresado cumple con un formato estricto (3 letras mayúsculas, un guion y 3 números).

INCLUDE Irvine32.inc

.data
    ; Textos que el programa va a mostrar en pantalla
    prompt BYTE "Ingresa el codigo (ej. TEC-123): ", 0
    msg_valido BYTE "Formato valido. La cadena cumple todas las reglas.", 13, 10, 0

    ;  Diferentes regaños (mensajes de error) dependiendo de en qué te equivoques 
    err_longitud BYTE "Formato invalido: La longitud no es igual a 7.", 13, 10, 0
    err_letras   BYTE "Formato invalido: Las posiciones 0-2 no son letras mayusculas (A-Z).", 13, 10, 0
    err_guion    BYTE "Formato invalido: Falta el separador '-' en la posicion 3.", 13, 10, 0
    err_digitos  BYTE "Formato invalido: Las posiciones 4-6 no son digitos (0-9).", 13, 10, 0

    buffer BYTE 20 DUP(0) ; Espacio en blanco para guardar lo que el usuario escriba.
    bytesLeidos DWORD ?   ; Aquí guardaremos cuántas letras/números escribió en total.

.code
main PROC
    ;Pedimos que escriban el código 
    mov edx, OFFSET prompt
    call WriteString
    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer
    call ReadString
    mov bytesLeidos, eax ; Guardamos cuántos caracteres escribió en total.

    ; REGLA 1: El código debe tener exactamente 7 caracteres
    cmp eax, 7
    jne error_longitud     ; Si no son exactamente 7, salta directo a mostrar el error de tamaño.
    mov esi, OFFSET buffer ; Ponemos nuestro "dedo" (puntero) en la primera letra de lo que escribió.
    
    ; REGLA 2: Los primeros 3 caracteres deben ser letras MAYÚSCULAS 
    mov ecx, 3 ; Preparamos un contador para revisar 3 letras
validar_letras:
    mov al, [esi] ; Leemos la letra actual.
    cmp al, 'A'
    jb error_letras        ; Si la letra es menor a la 'A' (en el alfabeto de la compu) marca error.
    cmp al, 'Z'
    ja error_letras        ; Si se pasa de la 'Z' (como las minúsculas), también marca error.
    inc esi                ; Movemos el "dedo" a la siguiente letra.
    loop validar_letras    ; Repetimos esto 3 veces.

    ; REGLA 3: El cuarto carácter (en medio) debe ser a fuerza un guion '-' 
    mov al, [esi] ; Leemos el carácter que sigue.
    cmp al, '-'
    jne error_guion        ; Si no es un guion, salta directo al error del guion.
    inc esi                ; Movemos nuestro "dedo" al siguiente espacio.
    
    ;REGLA 4: Los últimos 3 caracteres deben ser números del 0 al 9 
    mov ecx, 3 ; Preparamos un contador para revisar los 3 números.
validar_digitos:
    mov al, [esi] ; Leemos el carácter actual.
    cmp al, '0'
    jb error_digitos       ; Si es menor al '0', no es un número, marca error.
    cmp al, '9'
    ja error_digitos       ; Si se pasa del '9', tampoco es un número, marca error.
    inc esi                ; Movemos el "dedo" al siguiente carácter.
    loop validar_digitos   ; Repetimos esto 3 veces.
    
    ;  ÉXITO: Si llegó hasta aquí sin saltar a ningún error, el código es perfecto
    mov edx, OFFSET msg_valido
    call WriteString
    jmp fin ; Brincamos al final para no mostrar los mensajes de error.
    
    ; ZONA DE ERRORES: A esta parte solo llega si falló en alguna de las reglas
    
error_longitud:
    mov edx, OFFSET err_longitud
    call WriteString
    jmp fin ; Terminamos después de mostrar el error.
    
error_letras:
    mov edx, OFFSET err_letras
    call WriteString
    jmp fin
    
error_guion:
    mov edx, OFFSET err_guion
    call WriteString
    jmp fin
    
error_digitos:
    mov edx, OFFSET err_digitos
    call WriteString
    ; Aquí ya no necesitamos brincar porque ya estamos al final.
    
fin:
    exit 
main ENDP
END main
