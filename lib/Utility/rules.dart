String invalidNumber1ID = "in1";

String invalidVariable1ID = "vn2";

String invalidOperator1ID = "io1";
String invalidOperator2ID = "io2";
String invalidOperator3ID = "io3";
String invalidOperator4ID = "io4";

String variableID = "Variable";
String parenthesisID = "Paréntesis";
String keySymbolID = "Llave";
String operatorID = "Operador";
String numberID = "Número";

String printID = "Instrucción";
String sqrtID = "Instrucción";

String variableRegex = '[a-zA-Z][a-zA-Z0-9_]*';
String parenthesisRegex = r'[\(\)]';
String keySymbolRegex = r'[\{\}]';

String operatorRegex = r'[\+\-\*/\^]';
String numberRegex = r'[0-9]*[.]?[0-9]+';

String printRegex = 'print';
String sqrtRegex = 'sqrt \\(';

String invalidNumber1 = '$numberRegex $numberRegex|$numberRegex $variableRegex';

String invalidVariable1 = '$variableRegex $numberRegex|$variableRegex $variableRegex';

String invalidOperator1 = '(\\+ ?\\+|- ?-)|(\\- ?\\+)|$operatorRegex ?[\\*/\\^\\!]';
String invalidOperator2 = '\\( ?[\\*/\\^\\!]|$operatorRegex ?\\)';
String invalidOperator3 = '$operatorRegex ?\$';
String invalidOperator4 = '$variableRegex ?\\(|sqrt ?';

// Estos son los tokens que no se pueden usar
List invalidRegexID = [
  invalidNumber1ID,
  invalidVariable1ID,
  invalidOperator1ID,
  invalidOperator2ID,
  invalidOperator3ID,
  invalidOperator4ID,
];

// Estos son los tokens que se pueden y no pueden usar
Map<String, String> aLexicRulesValues = {
  printID: printRegex,
  sqrtID: sqrtRegex,
  invalidVariable1ID: invalidVariable1,
  invalidOperator1ID: invalidOperator1,
  invalidOperator2ID: invalidOperator2,
  invalidOperator3ID: invalidOperator3,
  invalidOperator4ID: invalidOperator4,
  variableID: variableRegex,
  parenthesisID: parenthesisRegex,
  keySymbolID: keySymbolRegex,
  operatorID: operatorRegex,
  invalidNumber1ID: invalidNumber1,
  numberID: numberRegex,
};

// Las llaves de los regex
List<String> aLexicRulesKeys = aLexicRulesValues.keys.toList();

// Regex especiales
String newLineID = "NewLine";
String loopStartRegex = "{";
String loopEndRegex = "} ?\\* ?([2-9]|[1-9][0-9])\$";
String completeLoopRegex = "$loopStartRegex$loopEndRegex";
String printVariableRegex = "print ?($variableRegex)";
