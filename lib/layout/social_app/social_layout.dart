import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/components/constants.dart';
import 'package:new_flutter2/shared/cubits/cubits.dart';

class SocialLayout extends StatefulWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  _SocialLayoutState createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        //var model = SocialCubit.get(context).model;
        return Scaffold(
          appBar: AppBar(
            title: const Text('News Feed'),
            actions: [
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
              defaultTextButton(
                function: () {
                  navigateAndFinish(context, const SocialLoginScreen());
                },
                text: 'logout',
              ),
            ],
          ),
          body: cubit.model == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    if (!FirebaseAuth.instance.currentUser!.emailVerified)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 65.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 20.0,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 4.0),
                              const Text('Please verified your Email'),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: defaultButton(
                                  function: () {
                                    FirebaseAuth.instance.currentUser!
                                        .sendEmailVerification()
                                        .then((value) {
                                      showToast(
                                        message: 'Check Your Mail',
                                        state: ToastState.success,
                                      );
                                    }).catchError((error) {
                                      printFullText(error.toString());
                                    });
                                  },
                                  radius: 40.0,
                                  text: 'Send',
                                  isUpperCase: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
