import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) :super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  dynamic displayTxt = 20;

  //Button Widget
  Widget calButton(String btnTxt,Color btnColor,Color txtColor){
    return  ElevatedButton(
      onPressed: (){
        calculation(btnTxt);
      },
     style: ElevatedButton.styleFrom(
       shape: const CircleBorder(),
       backgroundColor: btnColor,
       padding: const EdgeInsets.all(14),
     ),
      child: Text(btnTxt,
        style: TextStyle(
          fontSize: 28,
          color: txtColor,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Padding(
               padding: const EdgeInsets.all(10.0),
               child: Text('$text',
                 textAlign: TextAlign.end,
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 50,
                 ),
               ),
             ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calButton('AC',Colors.grey,Colors.black),
                calButton('+/-',Colors.grey,Colors.black),
                calButton('%',Colors.grey,Colors.black),
                calButton('/',Colors.amber.shade700,Colors.white),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calButton('7',Colors.grey.shade800,Colors.white),
                calButton('8',Colors.grey.shade800,Colors.white),
                calButton('9',Colors.grey.shade800,Colors.white),
                calButton('x',Colors.amber.shade700,Colors.white),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calButton('4',Colors.grey.shade800,Colors.white),
                calButton('5',Colors.grey.shade800,Colors.white),
                calButton('6',Colors.grey.shade800,Colors.white),
                calButton('-',Colors.amber.shade700,Colors.white),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calButton('1',Colors.grey.shade800,Colors.white),
                calButton('2',Colors.grey.shade800,Colors.white),
                calButton('3',Colors.grey.shade800,Colors.white),
                calButton('+',Colors.amber.shade700,Colors.white),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //this is button Zero
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.fromLTRB(24, 10, 110, 10),
                //     shape: const StadiumBorder(),
                //     backgroundColor: Colors.grey.shade800
                //   ),
                //
                //   onPressed: (){
                //     calculation('0');
                //   },
                //
                //   child: const Text('0',
                //     style: TextStyle(
                //         fontSize: 35,
                //         color: Colors.white),
                //   ),
                //
                // ),
                calButton('',Colors.black12,Colors.white),
                calButton('0',Colors.grey.shade800,Colors.white),
                calButton('.',Colors.grey.shade800,Colors.white),
                calButton('=',Colors.amber.shade700,Colors.white),
              ],
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text  ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    }
    else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      }
      else if( preOpr == '-') {
        finalResult = sub();
      }
      else if( preOpr == 'x') {
        finalResult = mul();
      }
      else if( preOpr == '/') {
        finalResult = div();
      }

    }
    else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      
      if(numOne == 0) {
        numOne = double.parse(result);
      }
      else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      }
      else if( opr == '-') {
        finalResult = sub();
      }
      else if( opr == 'x') {
        finalResult = mul();
      }
      else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    }
    else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    }
    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-$result';
      finalResult = result;

    }
    else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });

  }
  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }

}