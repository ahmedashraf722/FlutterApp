import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/styles/icon_broker.dart';

class SocialEditProfile extends StatefulWidget {
  const SocialEditProfile({Key? key}) : super(key: key);

  @override
  _SocialEditProfileState createState() => _SocialEditProfileState();
}

class _SocialEditProfileState extends State<SocialEditProfile> {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).imageProfile;
        var profileCover = SocialCubit.get(context).imageCover;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            actions: [
              defaultTextButton(
                function: () {
                  if (formKey.currentState!.validate()) {
                    cubit.updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  }
                },
                text: 'Update',
              ),
              const SizedBox(width: 25.0),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is SocialUpdateProfileLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 200.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                profileCover == null
                                    ? Container(
                                        height: 160,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
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
                                            userModel.cover.toString(),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 160,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6.0),
                                            topRight: Radius.circular(6.0),
                                          ),
                                        ),
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: FileImage(profileCover),
                                        ),
                                      ),
                                IconButton(
                                  onPressed: () {
                                    cubit.getCover();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                width: 110.0,
                                height: 110.0,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1.9,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                                child: profileImage == null
                                    ? CircleAvatar(
                                        radius: 15.0,
                                        backgroundImage: NetworkImage(
                                          userModel.image.toString(),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 15.0,
                                        backgroundImage:
                                            FileImage(profileImage),
                                      ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.getImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 15,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    if (cubit.imageProfile != null || cubit.imageCover != null)
                      Row(
                        children: [
                          if (cubit.imageProfile != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: () {
                                      cubit.uploadProfileImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                      );
                                    },
                                    text: 'Upload Profile',
                                    radius: 0.0,
                                    height: 40.0,
                                  ),
                                  if (state is SocialUpdateProfileLoadingState)
                                    const SizedBox(height: 5.0),
                                  if (state is SocialUpdateProfileLoadingState)
                                    const LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          const SizedBox(width: 10.0),
                          if (cubit.imageCover != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: () {
                                      cubit.uploadProfileImageCover(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                      );
                                    },
                                    text: 'Upload Cover',
                                    radius: 0.0,
                                    height: 40.0,
                                  ),
                                  if (state is SocialUpdateProfileLoadingState)
                                    const SizedBox(height: 5.0),
                                  if (state is SocialUpdateProfileLoadingState)
                                    const LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (cubit.imageProfile != null || cubit.imageCover != null)
                      const SizedBox(height: 15.0),
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
                    const SizedBox(height: 25.0),
                    defaultFormFieldF(
                      controller: nameController,
                      contentPadding: const EdgeInsets.all(10.0),
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'enter your Name';
                        }
                      },
                      onSubmit: (value) {},
                      label: 'Name',
                      iconPrefix: IconBroken.User,
                      onTab: () {},
                    ),
                    const SizedBox(height: 20.0),
                    defaultFormFieldF(
                      controller: bioController,
                      contentPadding: const EdgeInsets.all(10.0),
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'enter your bio';
                        }
                      },
                      label: 'Bio',
                      onSubmit: (value) {},
                      iconPrefix: IconBroken.Edit,
                      onTab: () {},
                    ),
                    const SizedBox(height: 20.0),
                    defaultFormFieldF(
                      controller: phoneController,
                      contentPadding: const EdgeInsets.all(10.0),
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'enter your phone';
                        }
                      },
                      onSubmit: (value) {},
                      label: 'Phone',
                      iconPrefix: IconBroken.Call,
                      onTab: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
