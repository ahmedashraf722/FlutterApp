import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/shop_app/cubit/states.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return cubit.userModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : userSetting(context, state);
      },
    );
  }

  Widget userSetting(BuildContext ctx, ShopStates state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if (state is ShopLoadingUpdateUserState)
              const LinearProgressIndicator(),
            const SizedBox(height: 20.0),
            defaultFormFieldF(
              controller: nameController,
              type: TextInputType.text,
              contentPadding: const EdgeInsets.all(10.0),
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
              controller: emailController,
              type: TextInputType.emailAddress,
              contentPadding: const EdgeInsets.all(10.0),
              validate: (value) {
                if (value!.isEmpty) {
                  return 'please enter your emailAddress';
                }
              },
              label: 'Email Address',
              iconPrefix: Icons.email_outlined,
              onTab: () {},
            ),
            const SizedBox(height: 20.0),
            defaultFormFieldF(
              controller: phoneController,
              type: TextInputType.phone,
              contentPadding: const EdgeInsets.all(10.0),
              validate: (value) {
                if (value!.isEmpty) {
                  return 'please enter your phoneNumber';
                }
              },
              label: 'Phone Number',
              iconPrefix: Icons.phone,
              onTab: () {},
            ),
            const SizedBox(height: 40.0),
            defaultButton(
              function: () {
                if (formKey.currentState!.validate()) {
                  ShopCubit.get(context).updateUserData(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                  );
                }
              },
              text: 'Update',
              radius: 40.0,
              isUpperCase: false,
            ),
            const SizedBox(height: 20.0),
            defaultButton(
              function: () {
                signOut(ctx, 'token');
              },
              text: 'Log out',
              radius: 40.0,
              isUpperCase: false,
            ),
          ],
        ),
      ),
    );
  }
}
