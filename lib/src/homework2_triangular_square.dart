import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          title: const Text(
            'Is it a square or a triangular? Or both?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: MyStateFull(),
      ),
    );
  }
}

class MyStateFull extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyStateFull> {
  final _controller = TextEditingController();
  int _enteredNumber = 0;
  String _conclusion = '';

  showAlertDialog(BuildContext context) {
    Widget okButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Ok.'),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        _enteredNumber.toString(),
      ),
      content: Text(
        _conclusion,
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  bool isSquare(int value) {
    int counter = 0;
    // ignore: always_put_control_body_on_new_line
    while (pow(counter, 2) < value) {
      counter++;
    }
    if (pow(counter, 2) == value) {
      return true;
    }
    return false;
  }

  bool isTriangular(int value) {
    int counter = 0;
    while (pow(counter, 3) < value) {
      counter++;
    }
    if (pow(counter, 3) == value) {
      return true;
    }
    return false;
  }

  void checkNumber() {
    setState(() {
      _controller.clear();
      if (isSquare(_enteredNumber) && isTriangular(_enteredNumber)) {
        _conclusion = 'The number $_enteredNumber is a square and a triangular.';
      } else if (isSquare(_enteredNumber)) {
        _conclusion = 'The number $_enteredNumber is a square.';
      } else if (isTriangular(_enteredNumber)) {
        _conclusion = 'The number $_enteredNumber is a triangular.';
      } else {
        _conclusion = 'The number $_enteredNumber is neither a square nor a triangular.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellowAccent,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            const Text('Enter a number to check if it is square or triangular.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (String value) {
                _enteredNumber = int.parse(value);
              },
            ),
            const SizedBox(height: 270),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  checkNumber();
                  showAlertDialog(context);
                },
                backgroundColor: Colors.black54,
                child: const Icon(Icons.check_sharp, color: Colors.teal),
              ),
            )
          ],
        ));
  }
}
