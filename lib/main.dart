import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter2/modules/counter/counter_screen.dart';
import 'package:new_flutter2/shared/bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterScreen(),
    );
  }
}
