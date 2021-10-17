import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_flutter2/bmi%20_calculator/bmi_result_screen.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  bool isMale = true;
  double height = 50.0;
  int weight = 40;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage('assets/images/male.png'),
                              width: 70,
                              height: 70,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Male',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: isMale ? Colors.blue : Colors.grey[400],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage('assets/images/female.png'),
                              width: 70,
                              height: 70,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: isMale ? Colors.grey[400] : Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'HEIGHT',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${height.round()}',
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 2.0),
                        const Text('cm'),
                      ],
                    ),
                    Slider(
                      autofocus: true,
                      value: height,
                      min: 50.0,
                      max: 220.0,
                      onChanged: (double value) {
                        setState(() {
                          height = value;
                        });
                      },
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'AGE',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$age',
                            style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                                heroTag: 'age--',
                                mini: true,
                                child: const Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                heroTag: 'age++',
                                mini: true,
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Weight',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$weight',
                            style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                },
                                heroTag: 'weight--',
                                mini: true,
                                child: const Icon(Icons.remove),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                heroTag: 'weight++',
                                mini: true,
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
              height: 50.0,
              onPressed: () {
                double result = weight / pow(height / 100, 2);
                //print(result.round());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return BmiResult(
                      isMale: isMale,
                      result: result.round(),
                      age: age,
                    );
                  }),
                );
              },
              child: const Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
