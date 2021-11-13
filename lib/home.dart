import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {

      if(equation == "0"){
        equation = buttonText;
      }else{
        equation = equation + buttonText;
      }

     switch (buttonText) {
       case "C" :
         equation = "0";
         result = "0";
         equationFontSize =38.0;
         resultFontSize = 48.0; 
         break;
        case "⌫":
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation.substring(0, equation.length -1);
          break;
        case "":
          equation = "0";
          break;
        case "=":
          equationFontSize = 38.0;
          resultFontSize = 48.0;

          expression = equation;
          expression = expression.replaceAll("x", "*");
          expression = expression.replaceAll("➗", "/");

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          } catch (e) {
            result = "Invalid";
          }

          break;
       default:
        
     }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Calculator",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.black,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("C", 1, Colors.red),
                          buildButton("⌫", 1, Colors.blue),
                          buildButton("➗", 1, Colors.blue),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("7", 1, Colors.grey),
                          buildButton("8", 1, Colors.grey),
                          buildButton("9", 1, Colors.grey),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("4", 1, Colors.grey),
                          buildButton("5", 1, Colors.grey),
                          buildButton("6", 1, Colors.grey),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("1", 1, Colors.grey),
                          buildButton("2", 1, Colors.grey),
                          buildButton("3", 1, Colors.grey),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(".", 1, Colors.grey),
                          buildButton("0", 1, Colors.grey),
                          buildButton("00", 1, Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("x", 1, Colors.blue),
                        ],
                      ),

                      TableRow(
                        children: [
                          buildButton("-", 1, Colors.blue),
                        ],
                      ),

                      TableRow(
                        children: [
                          buildButton("+", 1, Colors.blue),
                        ],
                      ),

                      TableRow(
                        children: [
                          buildButton("=", 2, Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
