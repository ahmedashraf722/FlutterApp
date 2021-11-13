import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/shop_layout.dart';
import 'package:new_flutter2/modules/shop_app/login/cubit/cubit.dart';
import 'package:new_flutter2/modules/shop_app/login/cubit/state.dart';
import 'package:new_flutter2/modules/shop_app/register/shop_register_screen.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  _ShopLoginScreenState createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
            }
          },
          builder: (context, state) {
            var cubit = ShopLoginCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            }
                          },
                          label: 'Email',
                          iconPrefix: Icons.email_outlined,
                          onTab: () {},
                        ),
                        const SizedBox(height: 20.0),
                        defaultFormFieldF(
                          controller: passwordController,
                          contentPadding: const EdgeInsets.all(10.0),
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {}
                          },
                          label: 'password',
                          iconPrefix: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            icon: Icon(cubit.suffixIcon),
                          ),
                          onTab: () {},
                        ),
                        const SizedBox(height: 30.0),
                        state is ShopLoginLoadingState
                            ? const CircularProgressIndicator()
                            : defaultButton(
                                text: 'LOGIN',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                radius: 40.0,
                              ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an Account?'),
                            const SizedBox(width: 5.0),
                            defaultTextButton(
                              function: () {
                                navigateAndFinish(
                                    context, const ShopRegisterScreen());
                              },
                              text: 'Register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
