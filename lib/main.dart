import 'package:flutter/material.dart';

void main() => runApp(TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _conversionType = 'F to C';
  TextEditingController _controller = TextEditingController();
  String _convertedValue = '';
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    setState(() {
      double inputTemp = double.parse(_controller.text);
      double result;
      String conversion;

      if (_conversionType == 'F to C') {
        result = (inputTemp - 32) * 5 / 9;
        conversion =
            'F to C: ${inputTemp.toStringAsFixed(2)} ➔ ${result.toStringAsFixed(2)}';
      } else {
        result = (inputTemp * 9 / 5) + 32;
        conversion =
            'C to F: ${inputTemp.toStringAsFixed(2)} ➔ ${result.toStringAsFixed(2)}';
      }

      _convertedValue = result.toStringAsFixed(2);
      _conversionHistory.insert(0, conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 'F to C',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value.toString();
                    });
                  },
                ),
                Text('Fahrenheit to Celsius'),
                Radio(
                  value: 'C to F',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value.toString();
                    });
                  },
                ),
                Text('Celsius to Fahrenheit'),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Converted Value: $_convertedValue',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_conversionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
