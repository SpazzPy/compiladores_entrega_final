import 'package:compiladores_entrega_final/Utility/response.dart';
import 'dart:core';
import 'package:compiladores_entrega_final/Utility/rules.dart';

Response codigoIntermedio(Response parseResult) {
  Response response = Response();

  if (!parseResult.successful) {
    response.successful = false;
    response.message = 'Error';
    return response;
  }

  var lines = parseResult.parseResult.split('\n');

  String indent = '  ';
  Set<String> parameters = {};
  Map<int, StringBuffer> blocks = {0: StringBuffer()};
  int loopLevel = 0;
  Map<int, String> loopMultipliers = {};

  RegExp regExp = RegExp(loopEndRegex);

  for (var line in lines) {
    line = line.trim();
    line = line.replaceAll("^", "**").replaceAll("sqrt", "Math.sqrt");
    if (line.isEmpty) continue;

    // Maneja los prints de variables
    if (line.startsWith(printRegex)) {
      String content = line.substring(printRegex.length).trim();
      blocks[loopLevel]!.write('${indent * (loopLevel + 1)}console.log($content);\n');
      continue;
    }

    // Maneja aperturas de ciclos
    if (line.contains('{')) {
      loopLevel++;
      blocks[loopLevel] = StringBuffer();
    } else if (line.contains('}')) {
      var match = regExp.firstMatch(line);

      if (match != null) {
        loopMultipliers[loopLevel - 1] = match.group(1)!;
      }

      String loopContent = blocks[loopLevel]!.toString();
      loopLevel--;

      // Si el ciclo tiene contenido y es del mismo nivel anterior, se agrega el contenido al bloque anterior
      if (loopContent.isNotEmpty && loopMultipliers.containsKey(loopLevel)) {
        String loopHeader = '${indent * (loopLevel + 1)}for (let i$loopLevel = 0; i$loopLevel < ${loopMultipliers[loopLevel]}; i$loopLevel++) {\n';
        blocks[loopLevel]!.write(loopHeader);
        blocks[loopLevel]!.write(loopContent);
        blocks[loopLevel]!.write('${indent * (loopLevel + 1)}}\n');
        loopMultipliers.remove(loopLevel);
        // Si el ciclo tiene contenido y es de un nivel anterior, se agrega indentacion y cierra el ciclo
      } else if (loopContent.isNotEmpty) {
        blocks[loopLevel]!.write(loopContent);
        blocks[loopLevel]!.write('${indent * (loopLevel + 1)}}\n');
      }
      // Al finalizar, se elimina el ciclo actual
      blocks.remove(loopLevel + 1);
    } else if (line.contains('=')) {
      blocks[loopLevel]!.write('${indent * (loopLevel + 1)}$line;\n');
    } else {
      parameters.add(line);
    }
  }

  StringBuffer jsFunction = StringBuffer();
  jsFunction.write('function myFunction(${parameters.join(', ')}) {\n');
  jsFunction.write(blocks[0]!.toString());
  jsFunction.write('${indent}return;\n');
  jsFunction.write('}\n');
  jsFunction.write('myFunction();');

  response.value = jsFunction.toString();
  return response;
}
