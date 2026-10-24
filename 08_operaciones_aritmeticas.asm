; 08- Operaciones Aritmeticas 
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que funciona como una calculadora para probar sumas, restas, 
; multiplicaciones, divisiones y ver qué pasa cuando los números no caben.

INCLUDE Irvine32.inc

.code
main PROC  

     ; PRUEBA 1: SUMA (ADD) Y RESTA (SUB)
     mov eax, 50        ; Ponemos un 50 en nuestra calculadora (EAX).
     mov ebx, 20        ; Preparamos un 20 aparte.

     add eax, ebx       ; Le sumamos el 20 al 50 (ahora tenemos 70).
     sub eax, 15        ; A ese 70 le restamos 15 (nos quedan 55).

     nop                ; Esto es solo una pausa, no hace nada.

     call DumpRegs      

     ; PRUEBA 2: CUANDO EL NÚMERO YA NO CABE (Bandera de Acarreo - CF)
     mov eax, 0
     mov al, 255        ; 255 es el número más grande que cabe en este pequeño espacio (AL).
     add al, 1          ; Le sumamos 1. Como ya no cabe (sería 256), se derrama y se enciende una alarma (bandera CF).

     nop
     call DumpRegs     

     ; PRUEBA 3: ERROR CON NÚMEROS POSITIVOS/NEGATIVOS (Bandera de Desbordamiento - OF)
     mov eax,0
     mov al, 127        ; Para números con signo (que pueden ser negativos), el máximo aquí es 127.
     add al, 1          ; Le sumamos 1. La compu se confunde pensando que es un número negativo y enciende la bandera de desbordamiento (OF).

     call DumpRegs      

     ; PRUEBA 4: MULTIPLICACIÓN NORMAL (MUL)
     mov eax, 25        ; Ponemos un 25.
     mov ebx, 3         ; Ponemos un 3.
     
    mul ebx            ; Multiplicamos 25 por 3. El resultado (75) cabe perfectamente en su caja normal.

     call DumpRegs   

     ; PRUEBA 5: MULTIPLICACIÓN GIGANTE (MUL)
     mov eax, 65537     ; Ponemos un número muy grande.
     mov ebx, 65537     ; Ponemos otro número muy grande.

     mul ebx            ; Al multiplicarlos, el resultado es tan inmenso que la computadora tiene que usar dos cajas juntas (EDX y EAX) para que quepa.

     ; PRUEBA 6: MULTIPLICACIÓN CON NÚMEROS NEGATIVOS (IMUL)
     mov eax, -5        ; Preparamos un número negativo (-5).
     mov ebx, 3         ; Preparamos un 3.

     imul ebx, eax, 3   ; Multiplicamos -5 por 3, y le decimos que guarde el resultado (-15) en EBX. 

     nop

     ; PRUEBA 7: DIVISIÓN NORMAL (DIV)
     mov eax, 125       ; Este es el número que vamos a dividir (125).
     mov edx, 0         ; "Limpiamos" esta caja (EDX) poniéndole un cero, porque la división usa dos cajas y no queremos que haya basura aquí.
     mov ebx, 12        ; Vamos a dividir entre 12.

     div ebx            ; Dividimos 125 entre 12.

     nop

     ; PRUEBA 8: DIVISIÓN CON NÚMEROS NEGATIVOS (IDIV)
     mov eax, -125      ; Queremos dividir -125.
     cdq                ; Truco mágico: Esto le avisa a la caja de al lado (EDX) que estamos usando un número negativo para que todo cuadre perfecto.
     mov ebx, 12        ; Vamos a dividir entre 12.

     idiv ebx           ; Hacemos la división especial para números con signo.

     nop

     exit               

main ENDP

END main
