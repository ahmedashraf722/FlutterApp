import 'package:flutter/material.dart';
import 'package:new_flutter2/modules/shop_app/login/shop_login_screen.dart';
import 'package:new_flutter2/shared/components/components.dart';
import 'package:new_flutter2/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boardingModel = [
    OnBoardingModel(
      image: 'assets/images/logo.png',
      title: 'Screen Title 1',
      body: 'Screen body 1',
    ),
    OnBoardingModel(
      image: 'assets/images/logo.png',
      title: 'Screen Title 2',
      body: 'Screen body 2',
    ),
    OnBoardingModel(
      image: 'assets/images/logo.png',
      title: 'Screen Title 3',
      body: 'Screen Body 3',
    ),
  ];
  var pageController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: () {
                navigateAndFinish(context, const ShopLoginScreen());
              },
              text: 'SKIP'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boardingModel.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBody(boardingModel[index]),
                itemCount: boardingModel.length,
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    spacing: 4.0,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                  ),
                  controller: pageController,
                  count: boardingModel.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(context, const ShopLoginScreen());
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(OnBoardingModel onBoardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                onBoardingModel.image,
              ),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            onBoardingModel.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            onBoardingModel.body,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
        ],
      );
}
