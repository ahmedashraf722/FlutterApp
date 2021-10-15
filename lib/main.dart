import 'package:flutter/material.dart';
import 'package:new_flutter2/messenger_design/messenger_design.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MessengerDesign(),
    );
  }
}
