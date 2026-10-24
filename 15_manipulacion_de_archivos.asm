; 15.- Manipulacion de archivos
; Materia: Lenguajes de Interfaz
; Nombre de la alumna: Guardado Pérez Dulce María
; Horario: 8:00 am - 09:00 am
; Nombre del Docente: Jose Luis Medina Jimenez
; Descripcion: Programa que crea un archivo de texto llamado "Inventario.txt", 
; escribe el texto "123" dentro de él, lo cierra y avisa si se guardó correctamente.

INCLUDE Irvine32.inc

.data 
    nombreArchivo BYTE "Inventario.txt", 0 
    texto BYTE "123", 0
    archivoHandle DWORD ? ; Espacio para guardar el identificador (o "llave") del archivo abierto

    mensajeExito BYTE "Archivo guardado:", 0
    mensajeError BYTE "No se pudo guardar el archivo", 0

.code 
main PROC  
    ; 1 Crear el archivo TXT
    mov edx, OFFSET nombreArchivo ; Preparamos el nombre del archivo que vamos a crear
    call CreateOutputFile         ; Crea y abre el archivo en el sistema

    cmp eax, INVALID_HANDLE_VALUE ; Revisa si el sistema devolvió un error al intentar crearlo
    je error                      ; Si hubo error, salta a la sección de error

    mov archivoHandle, eax        ; Si tuvo éxito, guarda el identificador del archivo para usarlo después

    ; 2 Escribir los caracteres
    mov eax, archivoHandle        ; Indicamos en qué archivo vamos a escribir
    mov edx, OFFSET texto         ; Indicamos qué texto vamos a escribir
    mov ecx, SIZEOF texto - 1     ; Indicamos la cantidad exacta de letras/números a escribir
    call WriteToFile              ; Escribe el texto dentro del archivo

    jc errorEscritura             ; Si falló la instrucción de escritura, salta al error de escritura

    cmp eax, SIZEOF texto - 1     ; Verifica que la cantidad de caracteres escritos sea la correcta
    jnr error                     ; Si no coinciden, salta a mostrar el error general

    ; 3 Guardar y cerrar el archivo
    mov eax, archivoHandle        
    call CloseFile                ; Cierra el archivo de forma segura para guardar los cambios en el disco duro

    test eax, eax                 ; Revisa si el cierre del archivo se realizó con éxito
    jz error                      ; Si falló al cerrar, salta al error

    mov edx, OFFSET mensajeExito  ; Prepara el mensaje indicando que todo salió bien
    call WriteString              ; Lo imprime en pantalla
    jmp fin                       ; Salta al final del programa para esquivar la sección de errores


errorEscritura: 
    ; Si hubo un error al escribir, primero cerramos el archivo para no dejarlo abierto en el sistema
    mov eax, archivoHandle
    call CloseFile

error: 
    ; Muestra el texto indicando que ocurrió una falla
    mov edx, OFFSET mensajeError
    call WriteString

fin: 
    exit ; Finaliza el programa
main ENDP

END main
