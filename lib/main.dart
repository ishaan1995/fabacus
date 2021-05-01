import 'package:fabacus/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fabacus',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: CalculatorHomeScreen(title: 'Fabacus'),
    );
  }
}

class CalculatorHomeScreen extends StatelessWidget {
  CalculatorHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double displayHeight = screen.height / 4;
    return Scaffold(
      body: Container(
        color: inputBg,
        child: SafeArea(
          child: Container(
            color: keysBg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Display(
                  displayHeight: displayHeight,
                ),
                Expanded(
                  child: KeyPad(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KeyButton extends StatelessWidget {
  KeyButton({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
          color: keys,
        ),
      ),
    );
  }
}

class OperatorButton extends StatelessWidget {
  OperatorButton({Key key, this.title, this.iconData}) : super(key: key);
  final String title;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex('#86A3DC');
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: iconData != null
          ? Icon(
              iconData,
              size: 28.0,
              color: color,
            )
          : Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
    );
  }
}

class KeyPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KeyButton(title: '7'),
                      KeyButton(title: '8'),
                      KeyButton(title: '9'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KeyButton(title: '4'),
                      KeyButton(title: '5'),
                      KeyButton(title: '6'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KeyButton(title: '1'),
                      KeyButton(title: '2'),
                      KeyButton(title: '3'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KeyButton(title: '0'),
                      KeyButton(title: '.'),
                      KeyButton(title: '='),
                    ],
                  )
                ],
              ),
              //color: Colors.green,
            ),
            flex: 7,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: HexColor.fromHex('#363637'), width: 1.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OperatorButton(
                    title: 'clr',
                    iconData: Icons.backspace_outlined,
                  ),
                  OperatorButton(
                    title: '÷',
                  ),
                  OperatorButton(
                    title: '×',
                  ),
                  OperatorButton(
                    title: '−',
                  ),
                  OperatorButton(
                    title: '+',
                  ),
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
              color: advanceOperatorsBg,
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}

class Display extends StatelessWidget {
  Display({Key key, this.displayHeight}) : super(key: key);
  final double displayHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayHeight,
      child: Container(
        color: inputBg,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      'DEG',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: HexColor.fromHex('#9A9FA4'),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(
                      Icons.more_vert,
                      color: HexColor.fromHex('#9A9FA4'),
                      size: 24.0,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
