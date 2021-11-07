import 'package:flutter/material.dart';
import 'package:new_flutter2/modules/shop_app/login/shop_login_screen.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/network/local/cache_helper.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  _ShopLayoutState createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salla'),
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.removeData(key: 'token').then((value) {
                if (value) {
                  navigateAndFinish(
                    context,
                    const ShopLoginScreen(),
                  );
                }
              });
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
