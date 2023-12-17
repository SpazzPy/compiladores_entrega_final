import 'package:compiladores_entrega_final/Utility/response.dart';
import 'package:compiladores_entrega_final/Utility/rules.dart';
import 'package:compiladores_entrega_final/Utility/utils.dart';

Response aSintactico(Response lexicResponse) {
  Response response = Response();

  // Si el analizador léxico no fue exitoso, se detiene el proceso
  if (!lexicResponse.successful) {
    response.successful = false;
    response.message = 'Error';
    return response;
  }

  String content = lexicResponse.value.replaceAll(RegExp(r'\s+'), ' ');
  List<String> temp = aLexicRulesKeys + [newLineID];
  for (String key in temp) {
    key += ":";
    content = content.replaceAll(key, '').trim();
  }

  List<String> lines = content.split('\\n');

  for (var i = 0; i < lines.length; i++) {
    String line = lines[i].replaceAll(RegExp(r'\s+'), ' ');
    line = line.trim();
    if (line.isEmpty) {
      continue;
    }

    List<String> equation = line.split("=");

    if (equation.length == 1) {
      response = processLeftSide(equation[0], response);
      if (!response.successful) {
        return response;
      }
    } else if (equation.length == 2) {
      response = processEquation(equation, response);
      if (!response.successful) {
        return response;
      }
    } else {
      response.successful = false;
      response.message = 'Hay más de un igual en la misma línea';
      return response;
    }

    response = balanceOpenCloseElements(line, response, "(", ")", "Los paréntesis");
    if (!response.successful) {
      return response;
    }

    response.value += line;
    if (i != lines.length - 1) {
      response.value += '\n';
    }
  }
  response.value = response.value.replaceAll(" }", "\n}");

  response = balanceOpenCloseElements(response.value, response, "{", "}", "Las llaves");
  if (!response.successful) {
    return response;
  }

  String tempString = response.value.replaceAll('\n', '').replaceAll(RegExp(r'\s+'), '');
  if (RegExp(completeLoopRegex).hasMatch(tempString)) {
    response.successful = false;
    response.message = 'Ciclo vacío';
    return response;
  }
  if (RegExp(r"\(\)").hasMatch(tempString)) {
    response.successful = false;
    response.message = 'Paréntesis vacío';
    return response;
  }

  response.lexicResult = lexicResponse.value;
  response.parseResult = response.value;
  return response;
}

Response processLeftSide(String side, Response r) {
  side = side.trim();
  String varRegex = '^${aLexicRulesValues[variableID]}\$';
  if (side.isEmpty) {
    r.successful = false;
    r.message = 'A la izquierda del igual debe haber una variable';
    return r;
  }

  if (side.startsWith("print") && !RegExp(printVariableRegex).hasMatch(side)) {
    r.successful = false;
    r.message = 'El print debe tener una variable';
    return r;
  }
  if (side.startsWith("sqrt") && !RegExp(sqrtRegex).hasMatch(side)) {
    r.successful = false;
    r.message = 'No se puede iniciar con: sqrt';
    return r;
  }

  r.successful = true;
  if (!RegExp(varRegex).hasMatch(side) && !RegExp("^$loopStartRegex\$").hasMatch(side) && !RegExp("^$loopEndRegex").hasMatch(side) && !RegExp("^$printVariableRegex\$").hasMatch(side)) {
    r.successful = false;
    r.message = 'No se puede iniciar con: $side';
  }
  return r;
}

Response processEquation(List<String> equation, Response r) {
  String leftSide = equation[0];
  String rightSide = equation[1];

  r = processLeftSide(leftSide, r);
  if (!r.successful) {
    return r;
  }

  if (rightSide.isEmpty) {
    r.successful = false;
    r.message = 'A la derecha del igual debe haber una expresión';
  } else {
    r = processContent(rightSide, r, false, true);
  }
  return r;
}

Response balanceOpenCloseElements(String content, Response r, String openElement, String closeElement, String elementName) {
  int openCount = 0;
  int closeCount = 0;

  for (int i = 0; i < content.length; i++) {
    // ignore: unrelated_type_equality_checks
    if (content[i] == openElement) {
      openCount++;
      // ignore: unrelated_type_equality_checks
    } else if (content[i] == closeElement) {
      closeCount++;
    }
  }

  if (openCount != closeCount) {
    r.successful = false;
    r.message = '$elementName no están balanceados';
    return r;
  }
  return r;
}
