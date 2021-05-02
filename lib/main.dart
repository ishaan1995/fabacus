import 'package:fabacus/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
  final TextEditingController _controller = TextEditingController();

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
                  controller: _controller,
                ),
                Expanded(
                  child: KeyPad(
                    controller: _controller,
                  ),
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
  KeyButton({Key key, this.title, this.controller}) : super(key: key);
  final String title;
  final TextEditingController controller;

  num doubleWithoutDecimalToInt(double val) {
    return val % 1 == 0 ? val.toInt() : val;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: new CircleBorder(),
        onTap: () {
          if (title == '=') {
            String expression = controller.text;
            expression = expression.replaceAll("×", "*");
            expression = expression.replaceAll("−", "-");
            expression = expression.replaceAll("÷", "/");
            //print("Expression is $expression");
            try {
              double result = expression.interpret().toDouble();
              controller.text = "${doubleWithoutDecimalToInt(result)}";
            } catch (error) {
              controller.text = "Invalid Expression";
            }
          } else {
            controller?.text += title;
          }
        },
        child: Padding(
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
        ),
      ),
    );
  }
}

class OperatorButton extends StatelessWidget {
  OperatorButton({Key key, this.title, this.iconData, this.controller})
      : super(key: key);
  final String title;
  final IconData iconData;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex('#86A3DC');
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: new CircleBorder(),
        onTap: () {
          if (title == 'clr') {
            controller?.text = "";
          } else {
            controller?.text += title;
          }
        },
        child: Padding(
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
        ),
      ),
    );
  }
}

class KeyPad extends StatelessWidget {
  KeyPad({Key key, this.controller}) : super(key: key);
  final TextEditingController controller;

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
                      KeyButton(title: '7', controller: controller),
                      KeyButton(title: '8', controller: controller),
                      KeyButton(title: '9', controller: controller),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KeyButton(title: '4', controller: controller),
                      KeyButton(title: '5', controller: controller),
                      KeyButton(title: '6', controller: controller),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KeyButton(title: '1', controller: controller),
                      KeyButton(title: '2', controller: controller),
                      KeyButton(title: '3', controller: controller),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      KeyButton(title: '0', controller: controller),
                      KeyButton(title: '.', controller: controller),
                      KeyButton(title: '=', controller: controller),
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
                    controller: controller,
                  ),
                  OperatorButton(
                    title: '÷',
                    controller: controller,
                  ),
                  OperatorButton(
                    title: '×',
                    controller: controller,
                  ),
                  OperatorButton(
                    title: '−',
                    controller: controller,
                  ),
                  OperatorButton(
                    title: '+',
                    controller: controller,
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

class Display extends StatefulWidget {
  Display({Key key, this.displayHeight, this.controller}) : super(key: key);
  final double displayHeight;
  final TextEditingController controller;

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.displayHeight,
      child: Container(
        color: inputBg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 8.0),
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
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  showCursor: true,
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                  cursorColor: HexColor.fromHex('#86A3DC'),
                  readOnly: true,
                  autofocus: true,
                  textAlign: TextAlign.right,
                  controller: widget.controller,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
