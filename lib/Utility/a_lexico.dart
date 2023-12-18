import 'package:compiladores_entrega_final/Utility/response.dart';
import 'package:compiladores_entrega_final/Utility/rules.dart';
import 'package:compiladores_entrega_final/Utility/utils.dart';

Response aLexico(String content) {
  Response response = Response();
  // Elimina espacios y tabs
  content = content.trim().replaceAll(RegExp(r' \t+'), ' ');

  if (content.isEmpty) {
    response.successful = false;
    response.message = 'Código fuente vacío';
    return response;
  }
  // divide el contenido por saltos de linea
  List lines = content.split('\n');
  for (var i = 0; i < lines.length; i++) {
    // procesa cada linea
    response = processContent(lines[i], response, true, false);
    if (!response.successful) {
      return response;
    } else {
      // si la linea no es la ultima, agrega un salto de linea
      if (i != lines.length - 1) {
        response.value += '$newLineID: \\n\n';
      }
    }
  }

  response.lexicResult = response.value;
  return response;
}
