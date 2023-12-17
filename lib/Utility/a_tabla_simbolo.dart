import 'package:compiladores_entrega_final/Utility/response.dart';
import 'package:compiladores_entrega_final/Utility/rules.dart';
import 'package:flutter/material.dart';

Response tablaSimbolo(Response semanticResult) {
  Response response = Response();

  if (!semanticResult.successful) {
    response.successful = false;
    response.message = 'Error';
    return response;
  }

  response.parseResult = semanticResult.parseResult;
  String lexicContent = semanticResult.lexicResult;

  // Split lexicContent into lines
  List<String> lines = lexicContent.split('\n');

  List<Map<String, String>> objs = [];
  int count = 1;
  for (var line in lines) {
    if (line.isEmpty) {
      continue;
    }
    List<String> parts = line.split(':');

    String tokenType = parts[0].trim();
    String tokenName = parts[1].trim();

    String tokenValue = "";
    if ([variableID, numberID].contains(tokenType)) {
      tokenValue = 'Numérico';
    } else if (tokenType == operatorID) {
      tokenValue = 'Operador';
    } else if (tokenType == newLineID) {
      tokenValue = 'Delimitador';
    } else if (tokenType == parenthesisID) {
      tokenValue = 'Contenedor';
    } else if (tokenType == keySymbolID) {
      tokenValue = 'Ciclo';
    } else if (tokenType == printID) {
      tokenValue = 'Instrucción';
    }

    Map<String, String> obj = {
      'a': count.toString(),
      'b': tokenType,
      'c': tokenName,
      'd': tokenValue,
    };
    objs.add(obj);
    count++;
  }

  // Construir la tabla
  response.table = buildTable(objs);

  return response;
}

Table buildTable(List<Map<String, String>> rows) {
  List<TableRow> tableRows = [];

  // Header
  tableRows.add(
    const TableRow(
      children: [
        Text('Posición', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Tipo', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Nombre', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Valor', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );

  // Rows
  for (var obj in rows) {
    tableRows.add(
      TableRow(
        children: [
          Text(obj['a']!, textAlign: TextAlign.center),
          Text(obj['b']!, textAlign: TextAlign.center),
          Text(obj['c']!, textAlign: TextAlign.center),
          Text(obj['d']!, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  return Table(
    border: TableBorder.all(),
    children: tableRows,
  );
}
