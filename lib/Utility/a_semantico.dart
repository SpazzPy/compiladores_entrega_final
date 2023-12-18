import 'package:compiladores_entrega_final/Utility/response.dart';
import 'package:compiladores_entrega_final/Utility/rules.dart';

Response aSemantico(Response parseResponse) {
  Response response = Response();

  if (!parseResponse.successful) {
    response.successful = false;
    response.message = 'Error';
    return response;
  }

  response.lexicResult = parseResponse.lexicResult;
  response.parseResult = parseResponse.parseResult;
  String parseContent = parseResponse.parseResult;
  Map<String, String> allVariables = {};

  for (var pc in parseContent.split("\n")) {
    pc = pc.trim();
    if (pc.isEmpty) {
      continue;
    }

    List<String> equation = pc.split("=");
    if (equation.isEmpty || equation.length > 2) {
      response.successful = false;
      response.message = 'Error: Semantic102';
      return response;
    }

    String varName = equation[0].trim();
    if (equation.length == 1) {
      // Revisa si es una variable
      Match? match = RegExp(aLexicRulesValues[variableID]!).firstMatch(varName);
      if (match != null) {
        String variable = match.group(0)!;
        if (!allVariables.keys.contains(variable)) {
          allVariables[varName] = 'Parámetro numérico';
        }
      }
      // Revisa si es un print con una variable
      match = RegExp(printVariableRegex).firstMatch(varName);
      if (match != null) {
        String variable = match.group(1)!;
        if (allVariables.keys.contains(variable)) {
          allVariables[varName] = 'Print numérico';
        } else {
          response.successful = false;
          response.message = 'La variable del print $variable no fue inicializada';
          return response;
        }
      }
      // Revisa si es una ecuacion
    } else if (equation.length == 2) {
      String expression = equation[1].trim();

      // Revisa si es un print con una expresion
      Iterable<Match> matches = RegExp(aLexicRulesValues[variableID]!).allMatches(expression);
      for (Match match in matches) {
        String variable = match.group(0)!;
        // Revisa si la variable fue inicializada y no es un sqrt
        if (!allVariables.keys.contains(variable) && !variable.startsWith("sqrt")) {
          response.successful = false;
          response.message = 'La variable $variable no fue inicializada';
          return response;
        }
      }
      // Revisa si es una variable
      if (!allVariables.keys.contains(varName)) {
        allVariables[varName] = 'Numérico';
      }
    }
  }

  // Une la llave y el valor de cada variable
  for (var element in allVariables.entries) {
    response.value += '${element.key}: ${element.value}\n';
  }

  return response;
}
