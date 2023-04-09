import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/Screens/profile/Profile_Screen.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';

class aboutModel {
  final String image;
  final String title;
  final String description;

  aboutModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

class about extends StatefulWidget {
  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  var boardController = PageController();
  bool isLast = false;
  List<aboutModel> boarding = [
    aboutModel(
      image: 'assets/images/soccer_basketballl.jpg',
      title: 'Sport Center',
      description: 'Our app offers a wide selection of high-quality soccer and basketball products from the best brands, with fast and reliable shipping. Shop now and get everything you need to succeed on the field or court! you will never regret it ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'about us',
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF130359),
                  Color(0xFF121879),
                  Color(0xFF2931A8),
                ],
                begin: AlignmentDirectional.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back,
                    color:  Color(0xF717217A),
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
        body: Column(
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

  Widget buildBoardingItem(aboutModel model) => Stack(
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
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.0,
              ),
              Text(
                '${model.title}',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.blue.shade900.withOpacity(1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                '${model.description}',
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}