import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/news_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/news_app/cubit/states.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return list.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => ScreenTypeLayout(
                  mobile: Builder(builder: (context) {
                    NewsCubit.get(context).setDesktop(false);
                    return buildArticleItem(list[index], context, index);
                  }),
                  desktop: Builder(builder: (context) {
                    NewsCubit.get(context).setDesktop(true);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildArticleItem(
                            list[index],
                            context,
                            index,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                   '${
                                    list[NewsCubit.get(context)
                                    .selectItemColorBusinessIndex]
                                     ['description']}',
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  breakpoints: const ScreenBreakpoints(
                    desktop: 600.0,
                    tablet: 300.0,
                    watch: 300.0,
                  ),
                ),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: list.length,
              );
      },
    );
  }
}
