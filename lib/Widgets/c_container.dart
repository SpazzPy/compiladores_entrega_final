import 'package:compiladores_entrega_final/Utility/response.dart';
import 'package:flutter/material.dart';
import 'package:compiladores_entrega_final/Widgets/c_text.dart';

class BasicContainer extends StatelessWidget {
  // Definimos las propiedades de la clase
  final Widget child;
  final int flexValue;
  final Color containerColor;
  final Color borderColor;
  final double borderWidth;
  final String title;
  final bool includeStatus;
  final Response response;

  // Constructor de la clase
  BasicContainer({
    Key? key,
    this.child = const SizedBox(),
    this.flexValue = 1,
    this.containerColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderWidth = 2.0,
    this.title = "Default Title",
    this.includeStatus = true,
    Response? response,
  })  : response = response ?? Response(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flexValue,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
              child: boldText(
                message: title,
              ),
            ),
            includeStatus
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
                    color: response.successful ? const Color.fromARGB(200, 46, 125, 50) : const Color.fromARGB(214, 180, 20, 20),
                    child: boldText(
                      textColor: Colors.white,
                      message: response.message,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
