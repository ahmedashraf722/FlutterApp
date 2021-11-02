import 'package:flutter/material.dart';
import 'package:new_flutter2/shared/components/components.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  _ShopLoginScreenState createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'login now to browse our hot offers',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 20.0),
            defaultFormFieldF(
              controller: emailController,
              contentPadding: const EdgeInsets.all(10.0),
              type: TextInputType.emailAddress,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'please enter your emailAddress';
                } else {
                  return '';
                }
              },
              label: 'Email',
              iconPrefix: Icons.email,
              onTab: () {},
            ),
            const SizedBox(height: 20.0),
            defaultFormFieldF(
              controller: passwordController,
              contentPadding: const EdgeInsets.all(10.0),
              type: TextInputType.visiblePassword,
              isPassword: true,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'please enter your password';
                } else {
                  return '';
                }
              },
              label: 'password',
              iconPrefix: Icons.lock,
              suffixIcon: Icons.visibility,
              onTab: () {},
            ),
          ],
        ),
      ),
    );
  }
}
