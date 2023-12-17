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
      Match? match = RegExp(aLexicRulesValues[variableID]!).firstMatch(varName);
      if (match != null) {
        String variable = match.group(0)!;
        if (!allVariables.keys.contains(variable)) {
          allVariables[varName] = 'Parámetro numérico';
        }
      }

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
    } else if (equation.length == 2) {
      String expression = equation[1].trim();

      Iterable<Match> matches = RegExp(aLexicRulesValues[variableID]!).allMatches(expression);
      for (Match match in matches) {
        String variable = match.group(0)!;
        if (!allVariables.keys.contains(variable) && !variable.startsWith("sqrt")) {
          response.successful = false;
          response.message = 'La variable $variable no fue inicializada';
          return response;
        }
      }

      if (!allVariables.keys.contains(varName)) {
        allVariables[varName] = 'Numérico';
      }
    }
  }

  for (var element in allVariables.entries) {
    response.value += '${element.key}: ${element.value}\n';
  }

  return response;
}
