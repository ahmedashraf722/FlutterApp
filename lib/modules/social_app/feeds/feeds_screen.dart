import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
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
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
              return buildPostItem();
            },
            separatorBuilder: (context, index) {
              return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0));
            },
            itemCount: 10,
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget buildPostItem() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/flagged/photo-1558411158-9d2bc0cea41c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Ahmed Ashraf',
                            style: TextStyle(
                              height: 1.2,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 18.0,
                          ),
                        ],
                      ),
                      Text(
                        'January 22,2021 at 10:00 am',
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
              "Lorem Ipsum is simply dummy text "
              "of the printing and typesetting industry."
              " Lorem Ipsum has been the industry's "
              "standard dummy text ever since the 1500s, "
              "when an unknown printer took a galley of "
              "type and scrambled it to make a type specimen book .",
              style: Theme.of(context).textTheme.subtitle1,
            ),
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
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
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
                        '1200',
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
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Chat,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        '225 comments',
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
                  onTap: () {},
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/flagged/photo-1558411158-9d2bc0cea41c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
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
                      onTap: () {},
                      child: const Icon(
                        IconBroken.Heart,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      'Like',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 16.0),
                    ),
                    const SizedBox(width: 15.0),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        IconBroken.Send,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      'Share',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 16.0),
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
