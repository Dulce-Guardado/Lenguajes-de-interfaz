; 10.- Obtencion de una cadena decimal
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que calcula e imprime el progreso de una descarga 
; (bytes descargados, faltantes, porcentaje y bloques completos).

.data
    ; Variables para guardar los resultados de los cálculos
    descargados DWORD ?
    pendientes  DWORD ?
    porcentaje  DWORD ?
    grupos      DWORD ?
    residuo     DWORD ? 

    buffer BYTE 11 DUP(?), 0 ; Espacio temporal para convertir los números a texto

    ; Mensajes que se mostrarán en la pantalla
    msgDesc BYTE "Bytes descargados: ", 0
    msgPend BYTE "Bytes pendientes: ", 0
    msgPorc BYTE "Porcentaje de avance: ", 0
    msgGrup BYTE "Grupos completos de 1024 bytes: ", 0
    msgResi BYTE "Residuo del agrupamiento: ", 0

.code 
main PROC 
    ; Calcula los bytes descargados multiplicando 125 sectores por 512 bytes
    mov eax, 125
    mov ebx, 512
    mul ebx
    mov descargados, eax

    ; Calcula los bytes que faltan restando los descargados a la meta (100,000)
    mov ebx, 100000
    sub ebx, eax
    mov pendientes, ebx

    ; Calcula el porcentaje de avance con una regla de tres
    mov eax, descargados 
    mov ebx, 100
    mul ebx                 ; Multiplica por 100
    mov ebx, 100000
    xor edx, edx            ; Limpia EDX antes de hacer la división
    div ebx                 ; Divide entre el total (100,000)
    mov porcentaje, eax

    ; Divide entre 1024 para obtener los bloques completos y el sobrante
    mov eax, descargados 
    mov ebx, 1024
    xor edx, edx
    div ebx
    mov grupos, eax         ; Cociente: bloques completos de 1024
    mov residuo, edx        ; Residuo: bytes que sobraron

    ; Imprime el texto y el número de bytes descargados
    mov edx, OFFSET msgDesc 
    call WriteString
    mov eax, descargados
    mov esi, OFFSET buffer
    call convertirDecimal   ; Convierte el número a texto para poder imprimirlo
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Imprime el texto y el número de bytes pendientes
    mov edx, OFFSET msgPend 
    call WriteString
    mov eax, pendientes
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Imprime el porcentaje de avance
    mov edx, OFFSET msgPorc 
    call WriteString
    mov eax, porcentaje
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    mov al, '%'             ; Imprime el símbolo "%" al final
    call WriteChar      
    call Crlf

    ; Imprime los grupos completos de 1024 bytes
    mov edx, OFFSET msgGrup 
    call WriteString
    mov eax, grupos
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Imprime el residuo
    mov edx, OFFSET msgResi 
    call WriteString
    mov eax, residuo
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit
main ENDP

convertirDecimal PROC 
    ; Subrutina que convierte un número a texto separando sus dígitos
    pushad
    mov ecx, 0
    mov ebx, 10

DividirLoop: 
    ; Divide el número entre 10 para aislar el último dígito
    xor edx, edx
    div ebx
    add dl, 30h             ; Convierte el dígito a su carácter de texto (ASCII)
    push dx                 ; Lo guarda temporalmente en la pila
    inc ecx
    cmp eax, 0
    jne DividirLoop         ; Repite el proceso hasta que ya no queden dígitos

ExtraerLoop: 
    ; Saca los dígitos de la pila y los acomoda en el buffer de texto
    pop dx
    mov [esi], dl
    inc esi
    loop ExtraerLoop

    mov BYTE PTR [esi], 0   ; Agrega un cero al final para indicar dónde termina el texto
    popad
    ret
convertirDecimal ENDP

END main
