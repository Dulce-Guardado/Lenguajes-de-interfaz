; 13.- Obtencion de una cadena hexadecimal
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que convierte un número a texto en formato hexadecimal para mostrarlo en pantalla.

INCLUDE Irvine32.inc

.data 
    numero    DWORD 12AB34CDh      ; El número que vamos a convertir.
    bufferHex BYTE 8 DUP('?'), 0   ; Espacio vacío de 8 caracteres reservado para guardar el resultado en texto.
    mensaje   BYTE "Hexadecimal: ", 0
     
.code 
main PROC
    ; Imprime el texto inicial
    mov edx, OFFSET mensaje
    call WriteString

    ; Preparamos los datos y llamamos a la conversión
    mov eax, numero                ; Cargamos el número original en EAX.
    mov esi, OFFSET bufferHex      ; Indicamos dónde queremos guardar el texto resultante.
    call ConvertirAHex             ; Ejecutamos la subrutina que hace el trabajo.

    ; Imprime el resultado ya convertido
    mov edx, OFFSET bufferHex
    call WriteString
    call Crlf

    exit
main ENDP

ConvertirAHex PROC 
    ; Subrutina que convierte el número a texto hexadecimal, carácter por carácter.
    pushad                  ; Respaldamos todos los registros para no perder información.
    
    add esi, 7              ; Movemos nuestra posición (puntero) hasta el último espacio vacío del texto.
    mov ecx, 8              ; Preparamos un contador para repetir el proceso 8 veces (para 8 dígitos).

CicloHex: 
    mov edx, eax
    and dl, 0Fh             ; Aislamos solo la última parte del número (equivalente a un solo dígito hexadecimal).

    cmp dl, 9
    jbe EsNumero            ; Si el valor es de 0 a 9, saltamos a "EsNumero".
    add dl, 37h             ; Si es mayor (10 a 15), le sumamos 37h para convertirlo en su carácter de texto (letras A-F).
    jmp GuardarDigito       ; Brincamos a guardarlo.

EsNumero: 
    add dl, 30h             ; Si era de 0 a 9, le sumamos 30h para convertirlo en su carácter de texto (números '0'-'9').

GuardarDigito: 
    mov [esi], dl           ; Escribimos el carácter final en el espacio reservado.
    shr eax, 4              ; Recorremos el número original para poner el siguiente dígito al final y procesarlo en la próxima vuelta.
    dec esi                 ; Movemos nuestra posición un espacio hacia atrás (de derecha a izquierda).
    loop CicloHex           ; Repetimos todo el ciclo hasta procesar los 8 dígitos.

    popad                   ; Restauramos los registros originales.
    ret                     ; Terminamos la subrutina y regresamos al código principal.
ConvertirAHex ENDP

END main
