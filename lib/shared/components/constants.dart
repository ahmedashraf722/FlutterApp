/*
25c922b157134d0aadefaa4453b13530


baseUrl ---  https://newsapi.org/v2/
urlMethod --- top-headlines?
query --- country=eg&category=business&apiKey=25c922b157134d0aadefaa4453b13530

*/

/*
search

baseUrl --- https://newsapi.org/v2
method --- /everything?
query ---  q=tesla&apiKey=25c922b157134d0aadefaa4453b13530

*/

import 'package:flutter/material.dart';
import 'package:new_flutter2/modules/shop_app/login/shop_login_screen.dart';
import 'package:new_flutter2/shared/network/local/cache_helper.dart';
import 'components.dart';

void signOut(BuildContext context, String key) {
  CacheHelper.removeData(key: key).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        const ShopLoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //size each chuck 800
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String? token = '';

String? uid = '';
