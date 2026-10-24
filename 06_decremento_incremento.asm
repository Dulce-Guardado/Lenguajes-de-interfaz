; 06- Decremento e incremento
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que simula un sistema de seguridad con contraseña y límite de intentos.

INCLUDE Irvine32.inc 

.data 
;  Aquí guardamos los mensajes que va a leer el usuario 
    msgPIN BYTE "Ingrese la clave: ",0  
    msgError BYTE "Clave Incorrecta.",0
    msgAcceso BYTE "Acceso permitido",0
    msgBloqueo BYTE "Sistema Bloqueado",0
    msgIntentos BYTE "Intentos restantes: ",0

    claveCorrecta = 1234 ; Nuestra contraseña secreta.

.code
main PROC
    mov ebx, 3          ; Le damos 3 intentos a la persona para empezar.
    
intentar:               ; Aquí empieza el ciclo donde le preguntamos la contraseña.
    
    mov edx, OFFSET msgPIN
    call WriteString    ; Mostramos el texto: "Ingrese la clave: "
    call ReadInt        ; Nos quedamos esperando a que la persona escriba el número y dé Enter.

    cmp eax, claveCorrecta ; Comparamos el número que escribió con el 1234.

    je acceso           ; Si son iguales, lo mandamos directo a la sección de éxito ("acceso").

    ; Si llega aquí, es porque se equivocó 
    mov edx, OFFSET msgError 
    call WriteString    ; Le decimos "Clave Incorrecta."
    call crlf           ; Damos un "Enter" (salto de línea).

    dec ebx             ; Le quitamos un intento.

    jz bloqueado        ; Si sus intentos llegan a cero, lo mandamos directo a la sección de "bloqueado".

    ; Si todavía le quedan intentos
    mov edx, OFFSET msgIntentos
    call WriteString    ; Mostramos el texto: "Intentos restantes: "

    mov eax, ebx
    call WriteDec       ; Mostramos el número de vidas que le sobran (2, o 1).
    call crlf           ; Damos otro salto de línea.

    jmp intentar        ; Lo regresamos arriba a la palabra "intentar" para que vuelva a probar.

acceso:                 ; SECCIÓN DE ÉXITO
    mov edx, OFFSET msgAcceso
    call WriteString    ; Le decimos "Acceso permitido"
    jmp fin             ; Brincamos al final para que el programa termine sin mostrar errores.

bloqueado:              ;SECCIÓN DE FRACASO
    mov edx, OFFSET msgBloqueo
    call WriteString    ; Le decimos "Sistema Bloqueado"
    jmp fin             

fin:
    exit               
main ENDP

END main
