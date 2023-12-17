import 'package:flutter/material.dart';

// Definimos una clase que representa una respuesta
class Response {
  bool successful; // estado de éxito, por defecto es falso
  String message; // mensaje de error, por defecto es una cadena vacía
  String value; // valor de resultado, por defecto es una cadena vacía
  String lexicResult; // resultado del análisis léxico, por defecto es una cadena vacía
  String parseResult; // resultado del análisis sintáctico, por defecto es nulo
  List? objects; // lista de objetos, por defecto es nulo
  Table? table; // tabla, por defecto es nulo

  // Constructor de la clase
  Response({
    this.successful = true,
    this.message = "Exito",
    this.value = "",
    this.lexicResult = "",
    this.parseResult = "",
    this.objects,
    this.table,
  });
}
