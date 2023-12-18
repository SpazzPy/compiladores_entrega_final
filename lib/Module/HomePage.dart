// ignore_for_file: use_build_context_synchronously

import 'package:compiladores_entrega_final/Utility/a_intermedio.dart';
import 'package:compiladores_entrega_final/Utility/a_semantico.dart';
import 'package:compiladores_entrega_final/Widgets/c_buttons.dart';
import 'package:flutter/material.dart';
import 'package:compiladores_entrega_final/Utility/a_lexico.dart';
import 'package:compiladores_entrega_final/Utility/a_sintactico.dart';
import 'package:compiladores_entrega_final/Utility/a_tabla_simbolo.dart';
import 'package:compiladores_entrega_final/Utility/response.dart';
import 'package:compiladores_entrega_final/Widgets/c_container.dart';
import 'package:compiladores_entrega_final/Widgets/c_text_field.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Home> {
  TextEditingController textController = TextEditingController();
  Response lexicResponse = Response();
  Response parseResponse = Response();
  Response semanticResponse = Response();
  Response symbolTableResponse = Response();
  Response intermediateResponse = Response();
  TextEditingController jsResultController = TextEditingController();

  // Definimos el número máximo de líneas para el texto por defecto
  int maxLines = 26;
  @override
  void initState() {
    // Establecemos el texto por defecto
    textController.text = '\n' * maxLines;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Definimos la lógica del compilador
    void compilerLogic(String content) {
      content = content.trim();

      // Actualizamos el estado después de que se haya completado el frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          // Realizamos el análisis léxico
          lexicResponse = aLexico(content);

          // Realizamos el análisis sintáctico
          parseResponse = aSintactico(lexicResponse);

          // Realizamos el análisis semántico
          semanticResponse = aSemantico(parseResponse);

          // Actualizamos la tabla de símbolos
          symbolTableResponse = tablaSimbolo(semanticResponse);

          // Generamos el código intermedio
          intermediateResponse = codigoIntermedio(symbolTableResponse);
        });
      });
    }

    void handleTextEmptiness(String value, {String insertValue = ""}) {
      String content = value;
      List<String> lines = value.split('\n');

      int cursorPos = textController.selection.start;

      // Coloca el cursor al inicio si el texto está vacío o si el cursor está fuera del rango
      if (cursorPos < 0 || cursorPos > value.length) {
        cursorPos = 0;
      }

      // Insertar el valor en la posición del cursor
      String newValue = value.substring(0, cursorPos) + insertValue + value.substring(cursorPos);

      if (lines.length < maxLines) {
        newValue += '\n' * (maxLines - lines.length);
      }

      compilerLogic(newValue);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            textController.text = newValue;
            textController.selection = TextSelection.collapsed(offset: cursorPos + insertValue.length);
          });
        }
      });
    }

    // Limpiar el texto y luego enviarlo al codigo fuente
    void pasteCodeIntoSource(String code) {
      code = code.split('\n').map((line) => line.trim()).join('\n');
      handleTextEmptiness(textController.text, insertValue: code);
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          Expanded(
            flex: 2,
            child: Row(
              children: [
                // Contenedor para el código fuente
                BasicContainer(
                  flexValue: 4,
                  title: "Código Fuente",
                  includeStatus: false,
                  child: CTextFieldInput(
                    textController: textController,
                    handleTextChange: handleTextEmptiness,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: MiscButtons(
                      onPressedTriangleArea: () {
                        String triangle = '''
                        b = 5
                        h = 10
                        area = (b * h) / 2
                        print area
                        ''';
                        pasteCodeIntoSource(triangle);
                      },
                      onPressedCuadraticEcuations: () {
                        String cuadratic = '''
                        a = 1
                        b = 5
                        c = 6
                        x1 = (-b + sqrt(b ^ 2 - 4 * a * c)) / (2 * a)
                        x2 = (-b - sqrt(b ^ 2 - 4 * a * c)) / (2 * a)
                        print x1
                        print x2
                        ''';
                        pasteCodeIntoSource(cuadratic);
                      },
                      onPressed2PointDistance: () {
                        String distance = '''
                        x1 = 1
                        y1 = 1
                        x2 = 4
                        y2 = 5
                        dist = sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
                        print dist
                        ''';
                        pasteCodeIntoSource(distance);
                      },
                      onPressedFactorial: () {
                        String factorial = '''
                        r = 1
                        i = 1
                        {
                          r = r * i
                          i = i + 1
                        } * 5
                        print r
                        ''';
                        pasteCodeIntoSource(factorial);
                      },
                      onPressedFibonacci: () {
                        String fib = '''
                        a = 0
                        b = 1
                        print a
                        print b
                        {
                          c = a + b
                          print c
                          a = b
                          b = c
                        } * 10
                        ''';
                        pasteCodeIntoSource(fib);
                      },
                      onPressedCopyJS: () async {
                        await Clipboard.setData(ClipboardData(text: intermediateResponse.value));
                        showCopiedSnackbar(context);
                      },
                      onPressedCopyResult: () async {
                        await Clipboard.setData(ClipboardData(text: jsResultController.text));
                        showCopiedSnackbar(context);
                      },
                      onPressedClearSource: () {
                        handleTextEmptiness('');
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      // Contenedor para el código intermedio
                      BasicContainer(
                        flexValue: 2,
                        title: "Generador de Código Intermediario",
                        response: intermediateResponse,
                        child: CTextFieldOutput(
                          content: intermediateResponse.value,
                        ),
                      ),
                      // Contenedor para el resultado de JS
                      BasicContainer(
                        flexValue: 1,
                        title: "Resultado",
                        response: intermediateResponse,
                        includeStatus: false,
                        child: DisplayJavaScript(
                          content: intermediateResponse.value,
                          finalResult: jsResultController,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Row
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Contenedor para el analizador léxico
                BasicContainer(
                  title: "Analizador Léxico",
                  response: lexicResponse,
                  child: CTextFieldOutput(
                    content: lexicResponse.value,
                  ),
                ),
                // Contenedor para el analizador sintáctico
                BasicContainer(
                  title: "Analizador Sintáctico",
                  response: parseResponse,
                  child: CTextFieldOutput(
                    content: parseResponse.value,
                  ),
                ),
                BasicContainer(
                  title: "Analizador Semántico",
                  response: semanticResponse,
                  child: CTextFieldOutput(
                    content: semanticResponse.value,
                  ),
                ),
                // Contenedor para la tabla de símbolos
                BasicContainer(
                  title: "Tabla de Símbolos",
                  response: symbolTableResponse,
                  child: SingleChildScrollView(
                    child: symbolTableResponse.table,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showCopiedSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Copied to clipboard')),
  );
}
