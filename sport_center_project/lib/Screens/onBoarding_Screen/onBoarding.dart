import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';

class BoardingModel {
  final String image;
  final String title;
  final String description;

  BoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/soccer_basketballl.jpg',
      title: 'Sport Center',
      description: 'Welcome to our Sport Center app. Here where you can find the best sport products you need about Soccer and Basketball.',
    ),
    BoardingModel(
      image: 'assets/images/sportNews.jpg',
      title: 'Sport News',
      description: 'Stay up to date with the latest sports news from around the world! With our personalized news feed, you\'ll never miss a moment of the action',
    ),
    BoardingModel(
      image: 'assets/images/chatbot.jpg',
      title: 'ChatBot',
      description: 'Our AI-powered chatbot is here to make your shopping experience easier and more enjoyable.\n'
          'Whether you need help finding the perfect product.',
    ),
    BoardingModel(
      image: 'assets/images/th.jpg',
      title: 'Flipping & Swiping',
      description: 'To show the product name and description just click on the product image to flip the product.\n'
          'Click on the arrow on the top right of the product.\n'
          'To delete product from your cart list you can swipe to left or right.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDEDEDE),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    // print('Last');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    // print('Not Last');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 430,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                  image: AssetImage(model.image),
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.grey, BlendMode.darken))),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.title}',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.blue.shade900.withOpacity(1),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 11.0,
            ),
            Text(
              '${model.description}',
              style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  // axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blue.shade900.withOpacity(1),
                    dotColor: Colors.grey.shade700,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, right: 3),
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue.shade900.withOpacity(1),
                    onPressed: () {
                      if (isLast == true) {
                        navigators.navigateTo(context, LoginScreen());
                        // VariablesUtils.onBoardingShow = false;
                        // submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 600,
                            ),
                            curve: Curves.easeInOutCubicEmphasized);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
