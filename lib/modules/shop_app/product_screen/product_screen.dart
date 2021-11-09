import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter2/layout/shop_app/cubit/cubit.dart';
import 'package:new_flutter2/layout/shop_app/cubit/states.dart';
import 'package:new_flutter2/models/shop_model/home_model.dart';
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
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return cubit.homeModel == null
            ? const Center(child: CircularProgressIndicator())
            : productsBuilder(cubit.homeModel!);
      },
    );
  }

  Widget productsBuilder(HomeModel model) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
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
                  (index) => buildGridProduct(model.data!.products[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model) {
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
                    const SizedBox(width: 7.0),
                    if (model.discount != 0)
                      Text(
                        '${model.discount.round()} %',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                    const Spacer(),
                    Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 20.0,
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
