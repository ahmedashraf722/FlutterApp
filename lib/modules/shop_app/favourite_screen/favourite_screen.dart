import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favourite Screen',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
