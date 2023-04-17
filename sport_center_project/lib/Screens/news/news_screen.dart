import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/Screens/home/categories_info/categories_info.dart';
import 'package:sport_center_project/Screens/product_component/product_component.dart';
import 'package:http/http.dart' as http;



class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // const HomeScreen({Key? key}) : super(key: key);
  // final List<Color> colors = [    Colors.red,    Colors.orange,    Colors.yellow,    Colors.green,    Colors.blue,    Colors.purple,  ];
  final List<String> images = [
    'assets/images/Soccer.jpg',
    'assets/images/basketball.jpg'
  ];
  final List<String> texts = ['Football', 'Basketball'];
  final List<String> items = ['All', 'Shoes', 'Shirts', 'Equipments', 'Balls'];
  var flipController = PageController();

  final carouselController = CarouselController();
  int indexItems = 0;
  int activatedIndex = 0;
  bool isBottomSheet = false;


  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Text('News'),
        centerTitle: true,
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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Breaking News',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CarouselSlider(
              items: images
                  .map(
                    (e) => Image(
                  image: AssetImage('${e}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
                  .toList(),
              options: CarouselOptions(
                height: 200,
                // aspectRatio: 10/6,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) =>
                    setState(() => activatedIndex = index),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            buildIndicator(),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Recent News',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),
            MasonryGridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 5,
                primary: false,
                shrinkWrap: true,
                itemCount:flipper.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= flipper.length) {
                    return SizedBox.shrink(); // Return an empty widget if index is out of bounds
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                ),
                                child: Container(
                                  // height: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/Soccer.jpg'), fit: BoxFit.cover)),

                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text('Description',style: TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }



  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activatedIndex,
      count: images.length,
      onDotClicked: animateToSlide,
      effect: SlideEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Colors.blue.shade900.withOpacity(1),
          dotColor: Colors.grey),
    );
  }

  void animateToSlide(int index) => carouselController.animateToPage(index);

}