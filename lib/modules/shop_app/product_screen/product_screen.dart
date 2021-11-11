import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/shop_app/cubit/states.dart';
import 'package:new_flutter2/models/shop_model/categories_model.dart';
import 'package:new_flutter2/models/shop_model/home_model.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/styles/colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopErrorHomeDataState) {
          const Center(child: CircularProgressIndicator());
        }
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.changeFavoriteModel.status!) {
            showToast(
              message: state.changeFavoriteModel.message.toString(),
              state: ToastState.failed,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return cubit.homeModel == null
            ? const Center(child: CircularProgressIndicator())
            : productsBuilder(
                cubit.homeModel!, context, cubit.categoriesModel!);
      },
    );
  }

  Widget productsBuilder(
      HomeModel model, BuildContext ctx, CategoriesModel categoriesModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image.toString()),
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            height: 100.0,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return buildCategoriesList(categoriesModel.data!.data![index]);
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(width: 10.0);
              },
              itemCount: categoriesModel.data!.data!.length,
            ),
          ),
          const SizedBox(height: 15.0),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'New Products',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1 / 1.56,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildGridProduct(model.data!.products[index], ctx),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesList(DataModel dataModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              dataModel.image.toString(),
            ),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            width: 100.0,
            child: Text(
              dataModel.name.toString(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model, BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.image.toString(),
                ),
                width: double.infinity,
                height: 180.0,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                Row(
                  children: [
                    Text(
                      '${model.price.round()} \$',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()} \$',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.brown,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    /* const SizedBox(width: 7.0),
                    if (model.discount != 0)
                      Text(
                        '${model.discount.round()} %',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.deepOrange,
                        ),
                      ),*/
                    const Spacer(),
                    Expanded(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
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
    );
  }
}
