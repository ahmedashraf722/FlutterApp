import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/styles/icon_broker.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  var postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var now = DateTime.now();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
            actions: [
              defaultTextButton(
                function: () {
                  if (cubit.postImage == null) {
                    cubit.createPost(
                      dateTimePost: now.toString(),
                      text: postController.text,
                    );
                  } else {
                    cubit.uploadPostImage(
                      dateTimePost: now.toString(),
                      text: postController.text,
                    );
                  }
                  postController.clear();
                  cubit.removePostImage();
                },
                text: 'post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(height: 15.0),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/flagged/photo-1558411158-9d2bc0cea41c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: Text(
                        'Ahmed Ashraf',
                        style: TextStyle(
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                      label: Text('what is on your mind...'),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                if(cubit.postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 220,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Image(
                        fit: BoxFit.cover,
                        image: FileImage(cubit.postImage!),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.close,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(width: 7.0),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('#tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
