; 14.- Captura y almacenamiento de datos numericos
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que pide una cantidad del 1 al 99, la suma a un inventario actual
; y muestra el resultado en pantalla, validando que la entrada sea correcta.

INCLUDE Irvine32.inc
.data
    mensajeEntrada BYTE "Cuantas unidades llegaron (1-99): ", 0
    mensajeError BYTE "Entrada invalida. Escribe solo digitos, de 1 a 99.", 13, 10, 0
    mensajeResultado BYTE "Existencia actual: ", 0
    mensajeUnidades BYTE " unidades", 13, 10, 0

    entrada BYTE 16 DUP(0) ; Espacio para guardar el texto que el usuario escribe
    salida BYTE 11 DUP(0)  ; Espacio para guardar el resultado final convertido a texto

    cantidadRecibida DWORD ?
    existenciaActual DWORD 25 ; El inventario empieza con 25 unidades

.code
main PROC

solicitarEntrada:
    mov edx, OFFSET mensajeEntrada
    call WriteString

    ; Lee lo que el usuario escribe y guarda en EAX la cantidad de caracteres ingresados
    mov edx, OFFSET entrada
    mov ecx, SIZEOF entrada
    call ReadString

    ; Verifica que el usuario haya escrito solo 1 o 2 caracteres
    cmp eax, 1
    jb entradaInvalida
    cmp eax, 2
    ja entradaInvalida

    ; Prepara la conversión de los caracteres de texto a un valor numérico real
    mov esi, OFFSET entrada
    mov ecx, eax
    xor ebx, ebx

convertirDigitos:
    movzx eax, BYTE PTR [esi] ; Lee el caracter actual
    cmp al, '0'
    jb entradaInvalida        ; Si es menor a '0', marca error (no es número)
    cmp al, '9'
    ja entradaInvalida        ; Si es mayor a '9', marca error (no es número)

    sub eax, '0'              ; Convierte el caracter a su valor matemático
    imul ebx, ebx, 10         ; Multiplica el acumulado por 10 para desplazar la cifra (decenas)
    add ebx, eax              ; Suma el nuevo número al total

    inc esi                   ; Avanza al siguiente caracter
    loop convertirDigitos

    ; Verifica que el número final esté dentro del rango permitido (1 a 99)
    cmp ebx, 1
    jb entradaInvalida
    cmp ebx, 99
    ja entradaInvalida

    mov cantidadRecibida, ebx ; Guarda la cantidad validada

    ; Suma las unidades recibidas al inventario que ya existía
    mov eax, existenciaActual
    add eax, cantidadRecibida
    mov existenciaActual, eax

    ; Llama a la subrutina para convertir el total numérico de nuevo a texto
    mov eax, existenciaActual
    mov edi, OFFSET salida
    call DwordToString

    ; Imprime en pantalla el texto, el total y la palabra "unidades"
    mov edx, OFFSET mensajeResultado
    call WriteString
    mov edx, OFFSET salida
    call WriteString
    mov edx, OFFSET mensajeUnidades
    call WriteString

    exit

entradaInvalida: 
    ; Muestra el mensaje de error y regresa al inicio para pedir el dato de nuevo
    mov edx, OFFSET mensajeError
    call WriteString
    jmp solicitarEntrada

main ENDP

DwordToString PROC USES eax ebx ecx edx edi
    ; Subrutina que convierte un número entero a una cadena de texto
    mov ebx, 10
    xor ecx, ecx

    ; Si el número es 0, lo escribe directamente y termina el proceso
    cmp eax, 0
    jne dividirNumero
    mov BYTE PTR [edi], '0'
    inc edi
    jmp terminarCadena

dividirNumero: 
    ; Divide el número entre 10 repetidamente para separar cada dígito
    xor edx, edx
    div ebx
    push edx               ; Guarda el residuo (el dígito suelto) en la pila
    inc ecx
    test eax, eax
    jnz dividirNumero      ; Repite hasta que el resultado de la división sea cero

escribirDigitos:
    ; Saca los dígitos de la pila (lo que invierte su orden) para escribirlos de izquierda a derecha
    pop edx
    add dl, '0'            ; Convierte el valor matemático a su caracter de texto
    mov BYTE PTR [edi], dl ; Lo guarda en el espacio de salida
    inc edi
    loop escribirDigitos

terminarCadena: 
    ; Coloca un byte nulo al final para indicarle al sistema que la cadena de texto terminó
    mov BYTE PTR [edi], 0
    ret
DwordToString ENDP

END main
