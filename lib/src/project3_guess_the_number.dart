import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyStateFull());
}
class MyStateFull extends StatefulWidget {
  const MyStateFull({super.key});

  _MyStateFull createState() => _MyStateFull();
}

class _MyStateFull extends State<MyStateFull> {
  ///variables
  late int randomNumber, guessedNumber;
  bool visibleTry = false;
  bool visibleTryAgain = false;
  String tryLessOrGreat = " ";
  Random rand = Random();
  final TextEditingController _controller = TextEditingController();

  ///#variables
  ///methods
  @override
  void initState() {
    super.initState();
    randomNumber = rand.nextInt(100) + 1;
    visibleTryAgain = visibleTry = false;
    tryLessOrGreat = "";
  }

  void init() {
    setState(() {
      randomNumber = rand.nextInt(100) + 1;
      visibleTry = false;
      visibleTryAgain = false;
      tryLessOrGreat = "";
    });
  }

  ///#methods
  void update() {
    setState(() {
      _controller.clear();
      visibleTry = true;
      if (guessedNumber > randomNumber) {
        tryLessOrGreat = "You tried $guessedNumber.\nTry less!";
      } else if (guessedNumber < randomNumber) {
        tryLessOrGreat = "You tried $guessedNumber.\nTry greater!";
      } else {
        tryLessOrGreat = "You tried $guessedNumber\nNice! You guessed it!";
        visibleTryAgain = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Random number generator!'),
            backgroundColor: Colors.blueGrey,
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              const Text(
                "I'm thinking of a number between 1 and 100",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Text(
                "It is your turn to guess it!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
                width: 1,
              ),
              Container(
                color: Colors.blueGrey,
                child: Visibility(
                  visible: visibleTry,
                  child: Text(
                    tryLessOrGreat,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.only(left: 13, right: 13),
                height: 140,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      "Try a number!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        guessedNumber = int.parse(value);
                      },
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: ElevatedButton(
                        onPressed: update,
                        child: const Text(
                          "Guess!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Visibility(
                visible: visibleTryAgain,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: ElevatedButton(
                    onPressed: init,
                    child: const Text(
                      "Try again!",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}