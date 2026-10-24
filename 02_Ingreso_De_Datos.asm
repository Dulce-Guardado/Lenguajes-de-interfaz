; 02.- Captura y desplegado de mensajes
; Materia: Lenguajes de Interfaz
; Nombre: Guardado Pérez Dulce María
; Horario: 08:00 am - 09:00 am
; Docente: Jose Luis Medina Jimenez
; Descripcion :Este programa funciona como un pequeño formulario: te pide que escribas tu nombre, lo guarda 
;en un espacio que preparamos para no pasarnos de letras, y luego lo vuelve a mostrar en la pantalla.

TITLE Plantilla
INCLUDE C:\irvine\Irvine32.inc

.data ; Aquí guardamos los textos y los espacios en blanco que vamos a usar.

mensaje BYTE "Escribe tu nombre: ",0 ; El texto que le va a aparecer a la persona.

nombre Byte 15 DUP(0) ; Separamos un espacio vacío para guardar hasta 15 letras del nombre.

.code  
main PROC 
    
    mov edx, OFFSET mensaje ; Agarramos el mensaje que creamos arriba.
    call WriteString ; Lo mostramos en la pantalla.

    mov edx, OFFSET nombre ; Le decimos a la computadora dónde queremos guardar lo que la persona escriba.
    mov ecx, SIZEOF nombre  ; Le ponemos el límite (15 letras) para que no escriban de más y cause errores.

    call ReadString ; Nos quedamos esperando a que la persona escriba su nombre y dé "Enter".
    call Crlf ; Damos un salto de línea (como un Enter) para que no se vea todo amontonado.

    mov edx, OFFSET nombre ; Volvemos a buscar el nombre que ya guardamos.
    call WriteString ; Lo imprimimos en la pantalla para que la persona lo vea.
    call Crlf ; Damos otro salto de línea por limpieza.
    
    exit ; Terminamos y cerramos el programa.

main ENDP
END main
