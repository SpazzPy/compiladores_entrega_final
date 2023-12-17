// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';

class CTextFieldInput extends StatefulWidget {
  TextEditingController textController;

  final Function(String) handleTextChange;

  CTextFieldInput({
    Key? key,
    required this.textController,
    required this.handleTextChange,
  }) : super(key: key);

  @override
  CTextFieldInputState createState() => CTextFieldInputState();
}

class CTextFieldInputState extends State<CTextFieldInput> {
  @override
  void initState() {
    super.initState();

    widget.handleTextChange(widget.textController.text);
  }

  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextField(
        controller: widget.textController,
        maxLines: null,
        decoration: null,
        onChanged: widget.handleTextChange,
      ),
    );
  }
}

class CTextFieldOutput extends StatefulWidget {
  String content;

  CTextFieldOutput({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  CTextFieldOutputState createState() => CTextFieldOutputState();
}

class CTextFieldOutputState extends State<CTextFieldOutput> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    textController.text = widget.content;
    return SingleChildScrollView(
      child: TextField(
        controller: textController,
        maxLines: null,
        decoration: null,
        readOnly: true,
      ),
    );
  }
}

class DisplayJavaScript extends StatefulWidget {
  final String content;
  TextEditingController finalResult;

  DisplayJavaScript({
    Key? key,
    required this.content,
    required this.finalResult,
  }) : super(key: key);

  @override
  _DisplayJavaScriptState createState() => _DisplayJavaScriptState();
}

class _DisplayJavaScriptState extends State<DisplayJavaScript> {
  final TextEditingController _textController = TextEditingController();
  late JavascriptRuntime jsRuntime;

  @override
  void initState() {
    super.initState();
    jsRuntime = getJavascriptRuntime();
    _runJsCode(widget.content);
  }

  @override
  void didUpdateWidget(DisplayJavaScript oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.content != oldWidget.content) {
      _textController.clear();
      _runJsCode(widget.content);
    }
  }

  Future<void> _runJsCode(String jsContent) async {
    String modifiedJsContent = '''
      (function() {
        let logOutput = '';
        // const originalConsoleLog = console.log;
        console.log = function(message) {
          logOutput += message + '\\n';
          // originalConsoleLog(message);
        };
        $jsContent
        return logOutput;
      })();
    ''';

    try {
      final result = await jsRuntime.evaluateAsync(modifiedJsContent);
      setState(() {
        _textController.text = result.toString();
        widget.finalResult.text = result.toString();
      });
    } catch (error) {
      setState(() {
        _textController.text = "Error executing JS code: $error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.content.isEmpty) {
      return Container();
    }

    return SingleChildScrollView(
      child: CTextFieldOutput(
        content: _textController.text,
      ),
    );
  }

  @override
  void dispose() {
    jsRuntime.dispose();
    super.dispose();
  }
}
