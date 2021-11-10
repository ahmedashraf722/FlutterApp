import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/shop_app/cubit/states.dart';
import 'package:new_flutter2/models/shop_model/favorites_model.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/styles/colors.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return state is ShopLoadingGetFavoriteState
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildFavoritesItem(
                      cubit.favoritesModel!.data!.data![index], context);
                },
                separatorBuilder: (context, index) {
                  return myDivider();
                },
                itemCount: cubit.favoritesModel!.data!.data!.length,
              );
      },
    );
  }

  Widget buildFavoritesItem(DataFavorites model, BuildContext ctx) {
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
                    model.product!.image.toString(),
                  ),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.product!.discount != 0)
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
                    model.product!.name.toString(),
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
                        '${model.product!.price.round()} \$',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice.round()} \$',
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
                            ShopCubit.get(ctx)
                                .changeFavorites(model.product!.id!);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                ShopCubit.get(ctx).favorites[model.product!.id]!
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
