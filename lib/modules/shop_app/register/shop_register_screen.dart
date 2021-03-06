import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/shop_layout.dart';
import 'package:new_flutter2/modules/shop_app/register/cubit/cubit.dart';
import 'package:new_flutter2/modules/shop_app/register/cubit/state.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatefulWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<ShopRegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterLoadingState) {
            const Center(child: CircularProgressIndicator());
          }
          if (state is ShopRegisterSuccessState) {
            showToast(
              message: state.registerModel.message.toString(),
              state: ToastState.failed,
            );
          }
          if (state is ShopRegisterSuccessState) {
            CacheHelper.saveData(
                    key: 'token', value: state.registerModel.data!.token)
                .then((value) {
              token = state.registerModel.data!.token;
              navigateAndFinish(context, const ShopLayout());
            });
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(height: 25.0),
                        defaultFormFieldF(
                          controller: nameController,
                          contentPadding: const EdgeInsets.all(10.0),
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your Name';
                            }
                          },
                          label: 'Name',
                          iconPrefix: Icons.person,
                          onTab: () {},
                        ),
                        const SizedBox(height: 20.0),
                        defaultFormFieldF(
                          controller: phoneController,
                          contentPadding: const EdgeInsets.all(10.0),
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                          },
                          label: 'Phone',
                          iconPrefix: Icons.call,
                          onTab: () {},
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
                            if (value.length <= 5) {
                              return 'Password should be 6 characters at least';
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
                        defaultButton(
                          text: 'REGISTER',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          radius: 40.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
