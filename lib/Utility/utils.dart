import 'package:compiladores_entrega_final/Utility/response.dart';
import 'package:compiladores_entrega_final/Utility/rules.dart';

// Esto procesa el contenido de una linea
Response processContent(String content, Response r, bool lexic, bool sintaxis) {
  content = content.trim();
  int index = 0;
  while (index < content.length) {
    bool matchFound = false;
    String substring = content.substring(index);

    // Si el substring empieza con un espacio, se ignora
    if (substring.startsWith(' ')) {
      index++;
      continue;
    }

    // Para cada regla, se intenta hacer un match
    for (String key in aLexicRulesKeys) {
      // si es el analizador lexico, se ignoran las expresiones invalidas
      if (lexic && invalidRegexID.contains(key)) {
        continue;
      }

      // Se extrae el regex de la regla
      String regex = aLexicRulesValues[key]!;

      // Si es el analizador lexico, se agrega el operador de igual
      if (lexic) {
        if (key == operatorID) {
          regex += r'|[\=]';
        }
      }

      Match? match = RegExp(regex).matchAsPrefix(substring);
      if (match != null) {
        String matchedString = match.group(0)!;

        // Si es el analizador sintactico, se revisa por regex invalidos
        if (sintaxis) {
          if (invalidRegexID.contains(key)) {
            r.successful = false;
            r.message = 'Error en la expresión: $matchedString';
            return r;
          }

          // Si es un ciclo, se revisa que no este dentro de una expresion
          if (matchedString == "{") {
            r.successful = false;
            r.message = 'No se puede iniciar un ciclo en una expresión';
            return r;
          }

          // Si es un ciclo, se revisa si es un simbolo, en dado caso, se revisa que el ciclo este completo
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

    // Si no se encontro un match, se detiene el proceso
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
