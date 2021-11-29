/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/models/social_model/message_user_model.dart';
import 'package:new_flutter2/models/social_model/social_user_model.dart';
import 'package:new_flutter2/shared/styles/colors.dart';
import 'package:new_flutter2/shared/styles/icon_broker.dart';

class ChatsDetailsScreen extends StatefulWidget {
  final SocialUserModel userModel;

  const ChatsDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  _ChatsDetailsScreenState createState() => _ChatsDetailsScreenState();
}

class _ChatsDetailsScreenState extends State<ChatsDetailsScreen> {
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessage(
        receiverId: widget.userModel.uID.toString(),
      );
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage:
                        NetworkImage(widget.userModel.image.toString()),
                  ),
                  const SizedBox(width: 15.0),
                  Text(widget.userModel.name.toString()),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  cubit.messages.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message = cubit.messages[index];
                              //printFullText(message.text.toString());
                              if (widget.userModel.uID != message.senderID) {
                                return buildMyMessage(message);
                              } else {
                                return buildMessage(message);
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 15.0);
                            },
                            itemCount: cubit.messages.length,
                          ),
                        ),
                  if (cubit.messageImage != null)
                    Column(
                      children: [
                        const SizedBox(height: 15.0),
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
                                image: FileImage(cubit.messageImage!),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.removeMessageImage();
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
                      ],
                    ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'send your message here...',
                            ),
                          ),
                        ),
                        Container(
                          height: 45.0,
                          decoration: const BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(5.0),
                              bottomEnd: Radius.circular(5.0),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              cubit.getMessageImage();
                            },
                            child: const Icon(
                              IconBroken.Paper_Upload,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Container(
                          height: 45.0,
                          decoration: const BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(5.0),
                              bottomEnd: Radius.circular(5.0),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              var now = DateTime.now();

                              cubit.sendMessage(
                                receiverId: widget.userModel.uID.toString(),
                                dataTime: now.toString(),
                                text: messageController.text.toString(),
                              );
                              messageController.clear();
                            },
                            child: const Icon(
                              IconBroken.Send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            bottomEnd: Radius.circular(10.0),
          ),
        ),
        child: Text(messageModel.text.toString()),
      ),
    );
  }

  Widget buildMyMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.4),
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0),
          ),
        ),
        child: Text(messageModel.text.toString()),
      ),
    );
  }
}
*/
