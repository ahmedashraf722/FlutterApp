import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/models/social_model/social_user_model.dart';
import 'package:new_flutter2/modules/social_app/chats_details_screen/chats_details.dart';
import 'package:new_flutter2/shared/components/components.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return cubit.users.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildChatItem(cubit.users[index]);
                },
                separatorBuilder: (context, index) {
                  return myDivider();
                },
                itemCount: cubit.users.length,
              );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model) {
    return InkWell(
      onTap: () {
        navigatorTo(
          context,
          ChatsDetailsScreen(
            userModel: model,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                model.image.toString(),
              ),
            ),
            const SizedBox(width: 15.0),
            Text(
              model.name.toString(),
              style: const TextStyle(
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
