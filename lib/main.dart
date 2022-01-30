import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(List<String> args) {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Simple Calculator"),
          backgroundColor: Colors.blue,
          ),
        body: SimpleCal(),  
      ),
    );
  }
}

class SimpleCal extends StatefulWidget {
  const SimpleCal({ Key? key }) : super(key: key);

  @override
  _SimpleCalState createState() => _SimpleCalState();
}

class _SimpleCalState extends State<SimpleCal> {

  String equation = "0";
  String result = "0";
  String operation = "0";


  void btnPressed(String btnText){
    setState(() {
      if(btnText == "AC"){
        equation = "0";
        result = "0";
      }else if(btnText =="Clear"){
        equation = equation.substring(0, equation.length-1);
        if(equation.isEmpty){
          equation ="0";
        }
      }else if(btnText =="="){
        try {
          operation = equation;
          Parser p = Parser();
          Expression exp = p.parse(operation);

          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();
        } catch (e) {
          result ="Error";
        }
      }else{
        if(equation == "0"){
          equation = btnText;
        }else{
          equation = equation + btnText;
        }
      }
    });
  }


  Widget buildButton(String btText, double btHeight, Color btColor){
          return Container(
                  height: MediaQuery.of(context).size.height * .1 * btHeight,
                  color: btColor,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
                      ),
                  padding: EdgeInsets.all(16),
                  onPressed: () => btnPressed(btText),
                  child: Text(
                    btText,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                )
           );

  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
          child: Text(equation, style: TextStyle(fontSize: 38.0),),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
          child: Text(result, style: TextStyle(fontSize: 48.0),),
        ),

        Expanded(child: Divider(),),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("AC", 1, Colors.redAccent),
                      buildButton("Clear", 1, Colors.blue),
                      buildButton("+", 1, Colors.blue),
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton("7", 1, Colors.black45),
                      buildButton("8", 1, Colors.black45),
                      buildButton("9", 1, Colors.black45),
                    ],
                  ),

                  TableRow(
                    children: [
                      buildButton("4", 1, Colors.black45),
                      buildButton("5", 1, Colors.black45),
                      buildButton("6", 1, Colors.black45),
                    ],
                    
                  ),

                  TableRow(
                    children: [
                      buildButton("1", 1, Colors.black45),
                      buildButton("2", 1, Colors.black45),
                      buildButton("3", 1, Colors.black45),
                    ],
                    
                  ),

                  TableRow(
                    children: [
                      buildButton(".", 1, Colors.black45),
                      buildButton("0", 1, Colors.black45),
                      buildButton("00", 1, Colors.black45),
                    ],
                    
                  ),
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * .25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("-", 1, Colors.blue),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton("*", 1, Colors.blue),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton("/", 1, Colors.blue),
                    ],
                  ),
                  TableRow(
                    children: [
                      buildButton("=", 2, Colors.redAccent),
                    ],
                  ), 
                ],
              ),
            ),
          ],
        ),


      ],
    );
  }
}