import 'package:flutter/material.dart';

void main() => runApp(const TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  String _selectedConversion = 'F to C';
  final TextEditingController _inputController = TextEditingController();
  double? _convertedValue;
  final List<String> _history = [];

  // Conversion functions
  double _fahrenheitToCelsius(double fahrenheit) => (fahrenheit - 32) * 5 / 9;

  double _celsiusToFahrenheit(double celsius) => (celsius * 9 / 5) + 32;

  void _convert() {
    double inputTemperature = double.tryParse(_inputController.text) ?? 0;
    double result;

    if (_selectedConversion == 'F to C') {
      result = _fahrenheitToCelsius(inputTemperature);
      _history.insert(0,
          'F to C: ${inputTemperature.toStringAsFixed(1)} => ${result.toStringAsFixed(2)}');
    } else {
      result = _celsiusToFahrenheit(inputTemperature);
      _history.insert(0,
          'C to F: ${inputTemperature.toStringAsFixed(1)} => ${result.toStringAsFixed(2)}');
    }

    setState(() {
      _convertedValue = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Conversion type selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                const Text('Fahrenheit to Celsius'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                const Text('Celsius to Fahrenheit'),
              ],
            ),

            // Input field
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Convert button
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),

            // Display converted value
            if (_convertedValue != null)
              Text(
                'Converted: ${_convertedValue!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
            const SizedBox(height: 20),

            // Conversion history
            const Text('History of conversions:'),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
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
