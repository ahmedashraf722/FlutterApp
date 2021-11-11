import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/shop_app/cubit/states.dart';
import 'package:new_flutter2/models/shop_model/categories_model.dart';
import 'package:new_flutter2/shared/components/components.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return cubit.categoriesModel == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) {
                  return listCategoriesItem(
                      cubit.categoriesModel!.data!.data![index]);
                },
                separatorBuilder: (context, index) {
                  return myDivider();
                },
                itemCount: cubit.categoriesModel!.data!.data!.length,
              );
      },
    );
  }

  Widget listCategoriesItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image.toString()),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20.0),
          Text(
            model.name.toString(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
