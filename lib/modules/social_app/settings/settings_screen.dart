import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/modules/social_app/edit_profile/social_edit_profile.dart';
import 'package:new_flutter2/shared/components/components.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              SizedBox(
                height: 200.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 160,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6.0),
                            topRight: Radius.circular(6.0),
                          ),
                        ),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            userModel!.cover.toString(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 110.0,
                        height: 110.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.9,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                            userModel.image.toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                userModel.name.toString(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 25.0,
                    ),
              ),
              Text(
                userModel.bio.toString(),
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'posts',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '250',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100K',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'Followers',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '50',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'Following',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: defaultButton(
                      function: () {},
                      text: 'Add Photo',
                      radius: 20.0,
                      width: MediaQuery.of(context).size.width / 3,
                      height: 32.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  defaultButton(
                    background: Colors.grey.shade400,
                    function: () {
                      navigatorTo(context, const SocialEditProfile());
                    },
                    text: 'Edit',
                    radius: 20.0,
                    width: MediaQuery.of(context).size.width / 4,
                    height: 32.0,
                  ),
                  const SizedBox(width: 10.0),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
