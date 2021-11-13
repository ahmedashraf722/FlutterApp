import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:new_flutter2/models/shop_model/search_model.dart';
import 'package:new_flutter2/modules/shop_app/search_screen/cubit/cubit.dart';
import 'package:new_flutter2/modules/shop_app/search_screen/cubit/state.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/styles/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<SearchScreen> {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopSearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormFieldF(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return ' must enter text....';
                        }
                      },
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          cubit.searchData(
                            text: searchController.text,
                          );
                        }
                      },
                      label: 'Search',
                      iconPrefix: Icons.search,
                      onTab: () {},
                    ),
                    const SizedBox(height: 10.0),
                    if (state is ShopSearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10.0),
                    if (state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildSearchItem(
                              cubit.searchModel!.data!.data![index],
                              context,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return myDivider();
                          },
                          itemCount: cubit.searchModel!.data!.data!.length,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(Product model, BuildContext ctx,
      {bool isOldPrice = false}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image.toString(),
                  ),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      height: 1.2,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price} \$',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice} \$',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.brown,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(ctx).changeFavorites(model.id!);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                            ShopCubit
                                .get(ctx)
                                .favorites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
