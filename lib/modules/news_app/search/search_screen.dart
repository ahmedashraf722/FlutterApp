import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/news_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/news_app/cubit/states.dart';
import 'package:new_flutter2/shared/components/components.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormFieldF(
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Search must enter...';
                    }
                    return '';
                  },
                  label: 'Search',
                  iconPrefix: Icons.search,
                  onSubmit: (value) {},
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  onTab: () {},
                ),
              ),
              Expanded(
                  child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildArticleItem(list[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: list.length,
              )),
            ],
          ),
        );
      },
    );
  }
}
