import 'package:compiladores_entrega_final/Utility/response.dart';
import 'package:compiladores_entrega_final/Utility/rules.dart';

Response processContent(String content, Response r, bool lexic, bool sintaxis) {
  content = content.trim();
  int index = 0;
  while (index < content.length) {
    bool matchFound = false;
    String substring = content.substring(index);
    if (substring.startsWith(' ')) {
      index++;
      continue;
    }
    for (String key in aLexicRulesKeys) {
      if (lexic && invalidRegexID.contains(key)) {
        continue;
      }

      String regex = aLexicRulesValues[key]!;

      if (lexic) {
        if (key == operatorID) {
          regex += r'|[\=]';
        }
      }

      Match? match = RegExp(regex).matchAsPrefix(substring);
      if (match != null) {
        String matchedString = match.group(0)!;

        if (sintaxis) {
          if (invalidRegexID.contains(key)) {
            r.successful = false;
            r.message = 'Error en la expresión: $matchedString';
            return r;
          }
          if (matchedString == "{") {
            r.successful = false;
            r.message = 'No se puede iniciar un ciclo en una expresión';
            return r;
          }
          if (key == keySymbolID) {
            Match? tempMatch = RegExp(loopEndRegex).matchAsPrefix(substring);
            if (tempMatch == null) {
              r.successful = false;
              r.message = 'Ciclo incompleto: $substring';
              return r;
            }
          }
        }

        if (lexic) {
          r.value += '$key: $matchedString\n';
        }

        index += matchedString.length;
        matchFound = true;
        break;
      }
    }
    if (!matchFound) {
      r.successful = false;
      if (lexic) {
        r.message = 'Token desconocido: ${content[index]}';
      } else if (sintaxis) {
        r.message = 'Expresión desconocida: ${content[index]}';
      }
      return r;
    }
  }
  return r;
}
