import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';

  void onClickedN() {
    setState(() {
      name = 'First App';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: const Icon(
          Icons.account_box_outlined,
        ),
        title: Text(
          name,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            color: const Color(0xff45da69),
            onPressed: () {
              setState(() {
                onClickedN();
              });
            },
            icon: const Icon(
              Icons.notifications_active,
            ),
          ),
          const Icon(
            Icons.search_outlined,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Image(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1544890225-2f3faec4cd60?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=625&q=80',
                    ),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 200,
                    color: Colors.brown.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: const Text(
                      'Hacker',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
