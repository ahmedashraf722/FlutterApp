import 'package:flutter/material.dart';
import 'package:new_flutter2/bmi%20_calculator/bmi_calculator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BmiCalculator(),
    );
  }
}
