import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Currency Converter Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final rate = 4.5;
  final _formKey = GlobalKey<FormState>();
  final _formValue = TextEditingController();
  double _valueToConvert = 0.0;
  String _convertedValue = '';
  void _convert() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/lei.png',
              alignment: AlignmentDirectional.topCenter,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Enter the amount of money:'),
              keyboardType: TextInputType.number,
              controller: _formValue,
              validator: (value) {
                // ignore: noop_primitive_operations
                if (value == null || value.isEmpty || double.tryParse(value.toString()) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _valueToConvert = double.parse(_formValue.text) * rate;
                    _convertedValue = _valueToConvert.toStringAsFixed(2);
                    _convertedValue = '$_convertedValue RON';
                  });
                } else {
                  setState(() {
                    _valueToConvert = 0.0;
                    _convertedValue = '';
                  });
                }
              },
              style: ElevatedButton.styleFrom(foregroundColor: Colors.yellow, backgroundColor: Colors.white10),
              child: const Text('Convert'),
            )
          ],
        ),
      ),
      //
    );
  }
}
