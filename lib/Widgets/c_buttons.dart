import 'dart:ffi';

import 'package:flutter/material.dart';

class CFloatingActionButton1 extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final IconData buttonIcon;

  CFloatingActionButton1({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonIcon,
  }) : super(key: key);

  @override
  CFloatingActionButton1State createState() => CFloatingActionButton1State();
}

class CFloatingActionButton1State extends State<CFloatingActionButton1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(widget.buttonIcon),
            ),
            Expanded(
              child: Text(
                widget.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiscButtons extends StatefulWidget {
  final VoidCallback onPressedTriangleArea;
  final VoidCallback onPressedCuadraticEcuations;
  final VoidCallback onPressed2PointDistance;
  final VoidCallback onPressedFactorial;
  final VoidCallback onPressedFibonacci;
  final VoidCallback onPressedCopyJS;
  final VoidCallback onPressedCopyResult;
  final VoidCallback onPressedClearSource;

  MiscButtons({
    Key? key,
    required this.onPressedTriangleArea,
    required this.onPressedCuadraticEcuations,
    required this.onPressed2PointDistance,
    required this.onPressedFactorial,
    required this.onPressedFibonacci,
    required this.onPressedCopyJS,
    required this.onPressedCopyResult,
    required this.onPressedClearSource,
  }) : super(key: key);

  @override
  MiscButtonsState createState() => MiscButtonsState();
}

class MiscButtonsState extends State<MiscButtons> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> cWidgets = [
      const Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Text(
              "Calcular",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
          ],
        ),
      ),
      CFloatingActionButton1(
        buttonText: "Area de un triangulo",
        onPressed: widget.onPressedTriangleArea,
        buttonIcon: Icons.change_history,
      ),
      CFloatingActionButton1(
        buttonText: "Cuadratica",
        onPressed: widget.onPressedCuadraticEcuations,
        buttonIcon: Icons.keyboard_double_arrow_up,
      ),
      CFloatingActionButton1(
        buttonText: "Distancia entre 2 puntos",
        onPressed: widget.onPressed2PointDistance,
        buttonIcon: Icons.sync_alt_outlined,
      ),
      CFloatingActionButton1(
        buttonText: "Factorial",
        onPressed: widget.onPressedFactorial,
        buttonIcon: Icons.priority_high_rounded,
      ),
      CFloatingActionButton1(
        buttonText: "Fibonacci",
        onPressed: widget.onPressedFibonacci,
        buttonIcon: Icons.replay_circle_filled_rounded,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Text(
              "Acciones",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
          ],
        ),
      ),
      CFloatingActionButton1(
        buttonText: "Copiar JS",
        onPressed: widget.onPressedCopyJS,
        buttonIcon: Icons.file_copy,
      ),
      CFloatingActionButton1(
        buttonText: "Copiar Resultado",
        onPressed: widget.onPressedCopyResult,
        buttonIcon: Icons.file_copy_outlined,
      ),
      CFloatingActionButton1(
        buttonText: "Limpiar Código",
        onPressed: widget.onPressedClearSource,
        buttonIcon: Icons.delete_forever,
      ),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: cWidgets.map((button) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: button,
        );
      }).toList(),
    );
  }
}
