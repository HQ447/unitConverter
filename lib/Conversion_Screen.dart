import 'package:flutter/material.dart';

class Conversion_Screen extends StatefulWidget{
  const Conversion_Screen({super.key});

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}
class _ConversionScreenState extends State<Conversion_Screen>{
  final TextEditingController _valueController = TextEditingController();
  String _inputUnit = 'Meter';
  String _outputUnit = 'Kilometer';
  String _answerUnit = '';
  String _convertedValue = '';

  void _convert() {
    double inputValue = double.tryParse(_valueController.text) ?? 0.0;
    double result = 0.0;

    // Convert input value to meters based on input unit
    if (_inputUnit == 'Kilometer') {
      inputValue *= 1000;
    } else if (_inputUnit == 'Centimeter') {
      inputValue /= 100;
    }

    // Convert meters to selected output unit
    if (_outputUnit == 'Kilometer') {
      result = inputValue / 1000;
    } else if (_outputUnit == 'Centimeter') {
      result = inputValue * 100;
    } else {
      result = inputValue; // in meters
    }

    setState(() {
      _convertedValue = result.toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Unit Conversion',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                DropdownButton<String>(
                  value: _inputUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _inputUnit = newValue!;
                    });
                  },
                  items: <String>['Meter', 'Kilometer', 'Centimeter']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const Spacer(),
                const Text(
                  "Convert to: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.blue),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: _outputUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _outputUnit = newValue!;
                    });
                  },
                  items: <String>['Kilometer', 'Meter', 'Centimeter']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:(){
                _convert();
                setState(() {
                  _answerUnit = _outputUnit;
                });
              },
              child: const Text(
                'Convert',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Converted value:  $_convertedValue $_answerUnit',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
