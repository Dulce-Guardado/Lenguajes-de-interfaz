; 01- Ciclos Numericos
; Materia: Lenguajes de Interfaz
; Nombre: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Este programa simplemente hace una cuenta regresiva desde el 5 hasta el 1
;y va mostrando cada número en la pantalla, uno debajo del otro.

INCLUDE Irvine32.inc

.data

.code ; Aquí empieza la parte donde van las instrucciones de nuestro programa.
main PROC 

    mov ecx, 5 ; Preparamos un contador que empieza en 5.

ciclo: ; Aquí inicia la repetición. Todo lo de abajo se repetirá hasta que el contador llegue a 0.
    
    mov eax, ecx ; Copiamos el número actual del contador para poder usarlo y mostrarlo.
    call WriteDec ; Mostramos ese número en la pantalla.
    call Crlf ; Damos un "Enter" para que el siguiente número salga abajo.

    loop ciclo ; Regresamos a la palabra "ciclo", le restamos 1 al contador y repetimos todo.

    exit ; Terminamos y cerramos el programa.
main ENDP
END main
