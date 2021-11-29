import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter2/responsive_adaptive_app/adaptive_indicator.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/components/constants.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  _MobileScreenState createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  var text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.teal,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login now',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  defaultFormFieldF(
                    validate: (String? value) {},
                    type: TextInputType.text,
                    onTab: () {},
                    controller: text,
                    label: 'name',
                  ),
                  const SizedBox(height: 10.0),
                  defaultFormFieldF(
                    validate: (String? value) {},
                    type: TextInputType.text,
                    onTab: () {},
                    controller: text,
                    label: 'password',
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: defaultButton(
                          text: 'Login',
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: defaultButton(
                          text: 'Register',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Center(child: AdaptiveIndicator(os: getOs())),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
