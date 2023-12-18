# Compiladores Entrega Final

### Autores
Danilsa María Polanco Collado 1-20-1546 \
Frannie Hilario Fermín Rodríguez 1-16-0408 \
Nachely Rodríguez Vásquez 2-19-0705


## Introducción
Este compilador es una herramienta que ayuda a desarrolladores y estudiantes a desarrollar formulas matematicas basicas desde un lenguaje sencilla a JavaScript

## Como lo ejecuto?
Se pueden descargar el archivo llamado [Compilador Ejecutable.zip](https://github.com/SpazzPy/compiladores_entrega_final/blob/main/Compilador%20Ejecutable.zip) o presionarlo para redirigirse hacie el .zip con el ejecutable. \
Una vez descargado, sin descomprimirlo pueden ejecutar el .exe

## Reglas del lenguaje

### Nombres de Variables:

Deben comenzar con una letra (mayúscula o minúscula). \
Pueden contener letras (mayúsculas o minúsculas), dígitos y guiones bajos. \

### Paréntesis:

Los paréntesis deben ser representados como "(" y ")". \

### Ciclos:

Inician con { en una línea, luego finalizan con } en otra línea. \
Al finalizar un ciclo, debe estar seguido por las repeticiones de la siguiente forma } * n. Siendo n un número del 2 al 99 \

### Operadores:

Los operadores válidos son "+", "-", "*", "/", "^". \
Debe tener una variable o un número antes y después. \

### Números:

Los números pueden ser enteros o decimales. \
Un número decimal debe tener al menos un dígito antes y después del punto decimal. \

### Instrucciones "print" y "sqrt":

"print" y "sqrt(" son instrucciones válidas. \
Print debe estar seguida de una variable válida. \
Sqrt debe estar seguido por un paréntesis de apertura “(“ luego por una expresión matemática y finalizada con paréntesis de cierre “)”. \

### Reglas para Tokens Inválidos:

Un número seguido de otro número o un número seguido de una variable. \
Una variable seguida de un número o una variable seguida de otra variable. \
Los operadores "+ +" o "- -" no son válidos, y los operadores "+ -" o cualquier operador seguido de "*", "/", "^" o "!" no son válidos. \
Los operadores "*", "/", "^" o "!" seguidos de "(" no son válidos. \
Un operador seguido del final de la línea no es válido. \
Una variable seguida de "(" no es válida. \

## Ejemplos
Al ejecutar el compilador, podras ver varias formulas pre hechas para facilitarle la comprension del lenguaje personalizado.
![image](https://github.com/SpazzPy/compiladores_entrega_final/assets/91347861/85d01d47-cf0c-49d8-9a2d-3e0c2d36e0a1)


