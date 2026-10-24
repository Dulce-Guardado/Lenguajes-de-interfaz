; 04- Saltos
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Este programa sirve para demostrar cómo podemos obligar a la computadora a "saltarse" una parte del código.
;Le damos un número inicial, luego le ordenamos que dé un salto hacia abajo ignorando lo que hay en el camino, y al final
;tomamos una "foto" para comprobar que efectivamente ignoró la instrucción que estaba en medio.

; Descripcion: Programa para mostrar cómo funcionan los "saltos" (brincarse líneas de código).

INCLUDE Irvine32.inc

.code
main PROC
    
    mov eax, 5 ; Guardamos un 5 en nuestro espacio de memoria (EAX).

    jmp continuar ; Le ordenamos a la computadora: "Brinca directamente a la palabra 'continuar'"
    
    mov eax, 10 ; Como dimos un salto, la computadora ignora esta línea. El 5 nunca cambia a 10.

continuar: ; Aquí es donde "aterriza" nuestro salto.
    
    call DumpRegs ;(mostramos los resultados en pantalla) para comprobar que EAX sigue siendo 5.

    exit
main ENDP

END main
