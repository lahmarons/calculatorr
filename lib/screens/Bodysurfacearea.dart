import 'package:flutter/material.dart';
import 'dart:math'; // Import dart:math for pow function

class Bodysurfacearea extends StatefulWidget {
  @override
  _BodysurfaceareaState createState() => _BodysurfaceareaState();
}

class _BodysurfaceareaState extends State<Bodysurfacearea> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _bsaResult = '';
  String _bmiResult = '';
  String _bsaMessage = '';
  String _bmiMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 157, 245),
        title: Text('BSA & BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              
              'Le BSA est une mesure de la surface totale externe du corps.\n  '
              'Le BMI est une mesure de la graisse corporelle basée sur la taille et le poids.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _heightController,
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _weightController,
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _calculateBsaAndBmi,
                    child: Text('Calculate BSA & BMI'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _clearFields,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Clear'),
                  ),
                  SizedBox(height: 20),
                  _bsaResult.isNotEmpty || _bmiResult.isNotEmpty
                      ? Column(
                          children: [
                            Text(
                              'Your Body Surface Area (BSA): $_bsaResult sqm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Your Body Mass Index (BMI): $_bmiResult kg/m²',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              _bsaMessage,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              _bmiMessage,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateBsaAndBmi() {
    if (_formKey.currentState!.validate()) {
      double height = double.parse(_heightController.text);
      double weight = double.parse(_weightController.text);
      double heightInMeters = height / 100;

      // Calculate BSA using Du Bois formula
      double bsa = 0.007184 * pow(height, 0.725) * pow(weight, 0.425);
      // Calculate BMI
      double bmi = weight / pow(heightInMeters, 2);

      setState(() {
        _bsaResult = bsa.toStringAsFixed(2);
        _bmiResult = bmi.toStringAsFixed(2);
        _setBsaMessage(bsa);
        _setBmiMessage(bmi);
      });
    }
  }

  void _setBsaMessage(double bsa) {
    if (bsa < 1.6) {
      _bsaMessage = 'Small body size';
    } else if (bsa >= 1.6 && bsa < 1.8) {
      _bsaMessage = 'Medium body size';
    } else {
      _bsaMessage = 'Large body size';
    }
  }

  void _setBmiMessage(double bmi) {
    if (bmi < 18.5) {
      _bmiMessage = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      _bmiMessage = 'Normal weight';
    } else if (bmi >= 25.0 && bmi < 29.9) {
      _bmiMessage = 'Overweight';
    } else if (bmi >= 30.0 && bmi < 34.9) {
      _bmiMessage = 'Obese (Class 1)';
    } else if (bmi >= 35.0 && bmi < 39.9) {
      _bmiMessage = 'Obese (Class 2)';
    } else {
      _bmiMessage = 'Obese (Class 3)';
    }
  }

  void _clearFields() {
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _bsaResult = '';
      _bmiResult = '';
      _bsaMessage = '';
      _bmiMessage = '';
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: Bodysurfacearea(),
  ));
}
