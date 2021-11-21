import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_cubit.dart';
import 'package:new_flutter2/layout/social_app/cubit/social_state.dart';
import 'package:new_flutter2/models/social_model/post_model.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/styles/colors.dart';
import 'package:new_flutter2/shared/styles/icon_broker.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return cubit.posts.isEmpty && cubit.model == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: const EdgeInsets.all(10.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const Image(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80'),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Communicate with Friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return buildPostItem(cubit.posts[index], index);
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0));
                      },
                      itemCount: cubit.posts.length,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              );
      },
    );
  }

  Widget buildPostItem(SocialPostModel postModel, int index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    postModel.image.toString(),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            postModel.name.toString(),
                            style: const TextStyle(
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          const Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 18.0,
                          ),
                        ],
                      ),
                      Text(
                        postModel.datePost.toString(),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15.0),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
            myDivider(paddingH: 0.0),
            Text(
              postModel.text.toString(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 5.0,
                  children: [
                    SizedBox(
                      height: 20.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text(
                          '#software',
                          style: TextStyle(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                      child: MaterialButton(
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: const Text(
                          '#software_devemlpment',
                          style: TextStyle(
                            color: defaultColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            if (postModel.postImage != '')
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      postModel.postImage.toString(),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        SocialCubit.get(context).likes[index].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {

                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Chat,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        '${SocialCubit.get(context).comments[index]} comments',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            myDivider(paddingH: 0.0),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .commentPost(SocialCubit.get(context).postId[index]);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          SocialCubit.get(context).model!.image.toString(),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Write a comment.....',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context).likePost(
                            SocialCubit.get(context).postId[index]);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            'Like',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
