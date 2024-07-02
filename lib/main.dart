import 'package:flutter/material.dart';
import 'package:ma_carte_visite/screens/CombinedCalculator.dart';
import 'package:ma_carte_visite/screens/CreatinineCockcroftGault.dart';
import 'package:ma_carte_visite/screens/HomePage.dart';
import 'package:ma_carte_visite/screens/hba1c_eag_calculator.dart';
import 'package:ma_carte_visite/screens/Bodysurfacearea.dart';
import 'package:ma_carte_visite/screens/RAC.dart';
import 'package:ma_carte_visite/screens/srr_calculator.dart';
import 'package:ma_carte_visite/screens/CardioGloboriskCalculator.dart';
import 'package:ma_carte_visite/screens/ACT.dart';
import 'package:ma_carte_visite/screens/MMRCCalculator.dart'; // Import correct du fichier MMRCCalculator.dart

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/combinedcalculator': (context) => CombinedCalculator(),
        '/RiskCalculator': (context) => CardioGloboriskCalculator(),
        '/Hba1cCalculator': (context) => HbA1cCalculator(),
        '/Bodysurfacearea': (context) => Bodysurfacearea(),
        '/CreatinineCockcroftGault': (context) => CockcroftGaultCalculator(),
        '/racCalculator': (context) => RACCalculator(),
        '/srrCalculator': (context) => KFRECalculator(),
        '/ACTCcalculator': (context) => ACTCalculator(),
        '/cardioGloboriskCalculator': (context) => CardioGloboriskCalculator(),
        '/MMRCCalculator': (context) =>
            MMRCalculator(), // Ajoutez la route pour le calculateur MMRC
      },
    );
  }
}
