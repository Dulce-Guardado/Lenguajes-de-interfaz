; 02.- Captura y desplegado de mensajes
; Materia: Lenguajes de Interfaz
; Nombre: Guardado Pérez Dulce María
; Horario: 08:00 am - 09:00 am
; Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que solicita un nombre por teclado, lo almacena en un buffer 
; con límite de caracteres y lo imprime de vuelta en la consola.

TITLE Plantilla
INCLUDE C:\irvine\Irvine32.inc

.data ; Sección para declarar variables y constantes de memoria

mensaje BYTE "Escribe tu nombre: ",0 ; Cadena de texto para solicitar la entrada al usuario.

nombre Byte 15 DUP(0) ; Buffer reservado de 15 bytes para almacenar el texto ingresado.

.code  
main PROC 
    
    mov edx, OFFSET mensaje ; Carga la dirección de memoria del mensaje en EDX.
    call WriteString        ; Imprime la cadena en la consola.

    mov edx, OFFSET nombre  ; Carga en EDX la dirección del buffer donde se guardará la entrada.
    mov ecx, SIZEOF nombre  ; Establece en ECX el límite máximo de caracteres permitidos (15).

    call ReadString         ; Captura la entrada del teclado y la almacena en el buffer.
    call Crlf               ; Imprime un salto de línea en la consola.

    mov edx, OFFSET nombre  ; Carga nuevamente la dirección del buffer que ahora contiene el nombre.
    call WriteString        ; Imprime el texto capturado en la consola.
    call Crlf               ; Imprime un salto de línea final.
    
    exit                    ; Finaliza la ejecución del programa.

main ENDP
END main
