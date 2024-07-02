import 'package:flutter/material.dart';

class HbA1cCalculator extends StatefulWidget {
  @override
  _HbA1cCalculatorState createState() => _HbA1cCalculatorState();
}

class _HbA1cCalculatorState extends State<HbA1cCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hba1cController = TextEditingController();
  String _message = '';
  String _evaluation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 157, 245),
        title: Text('HbA1c Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Le calcul de l\'HbA1c (hémoglobine glyquée) permet d\'estimer la glycémie moyenne (eAG) '
              'sur les 2-3 derniers mois.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(  
                    controller: _hba1cController,
                    decoration: InputDecoration(labelText: 'HbA1c ( %)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your HbA1c level';
                      }
                      try {
                        double.parse(value);
                      } catch (e) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _calculateHbA1c,
                    child: Text('Calculate'),
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
                  Center(
                    child: Text(
                      _message,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      _evaluation,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _getEvaluationColor()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateHbA1c() {
    if (_formKey.currentState!.validate()) {
      double hba1c = double.parse(_hba1cController.text);

      double eAG = (28.7 * hba1c) - 46.7;

      setState(() {
        _message =
            'Your estimated Average Glucose (eAG) is ${eAG.toStringAsFixed(2)} mg/dL.';
        _evaluateHbA1c(hba1c);
      });
    }
  }

  void _evaluateHbA1c(double hba1c) {
    if (hba1c < 5.7) {
      _evaluation = 'Normal HbA1c Level';
    } else if (hba1c >= 5.7 && hba1c <= 6.4) {
      _evaluation = 'Pre-diabetic HbA1c Level';
    } else {
      _evaluation = 'Diabetic HbA1c Level';
    }
  }

  Color _getEvaluationColor() {
    if (_evaluation.contains('Normal')) {
      return Colors.green;
    } else if (_evaluation.contains('Pre-diabetic')) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  void _clearFields() {
    _hba1cController.clear();
    setState(() {
      _message = '';
      _evaluation = '';
    });
  }

  @override
  void dispose() {
    _hba1cController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: HbA1cCalculator(),
  ));
}
