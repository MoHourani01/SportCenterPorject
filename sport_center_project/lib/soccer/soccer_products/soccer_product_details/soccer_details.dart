import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/soccer/soccer_layout/soccer_screen.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<String> images = [
    'assets/images/basketball.jpg',
    'assets/images/basketball.jpg',
    'assets/images/basketball.jpg',
    'assets/images/basketball.jpg',
     ];

  Widget buildSizeButton({title, isSeleted}) {
    return MaterialButton(
      height: 40,
      minWidth: 40,
      elevation: 0,
      color: isSeleted ? Color(0xff8f7fc4) : Color(0xffe8e8e8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSeleted ? Colors.white : Color(0xff727274),
          ),
        ),
      ),
      onPressed: () {},
    );
  }

  int activatedIndex = 0;
  int dotIndex=0;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];

  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    scrollPhysics: ScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    height: double.infinity,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    reverse: false,
                    onPageChanged: (index, reason)=>
                        setState(()=>dotIndex=index),
                  ),
                  items: images
                      .map(
                        (e) => Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffb2adca).withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10.0,
                            offset: -Offset(0, 3),
                          )
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(e),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                              },
                              icon: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Color(0xffae9fe0),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.shopping_bag_rounded,
                                  color: Color(0xffae9fe0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
            buildIndicator(),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Soccer",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff39393b),
                          ),
                        ),
                        Text(
                          "\$120",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff39393b),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Price Incluslve of all Texes",
                      style: TextStyle(
                        color: Color(0xff979797),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Size",
                          style: TextStyle(
                            color: Color(0xff979797),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffac9ddd),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i=0; i<sizes.length; i++)
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      activatedIndex=i;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: activatedIndex == i
                                            ? Color(0xff9985cc).withOpacity(1)
                                            : Colors.white70,
                                        borderRadius: BorderRadius.circular(6)),
                                    child:Text(
                                      sizes[i],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: sizes[i] == sizes[activatedIndex]
                                            ? Colors.white
                                            : Colors.blueGrey.shade900
                                            .withOpacity(1),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Color(0xff317aaf),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xfff19a9c),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description"),
                            Container(
                              width: 50,
                              child: Divider(
                                  thickness: 3,
                                  color: Color(0xff6b648f)
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Delivery"),
                            Container(
                              width: 50,
                              child: Divider(
                                  thickness: 3, color: Colors.transparent),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Reviews"),
                            Container(
                              width: 50,
                              child: Divider(
                                thickness: 3,
                                color: Colors.transparent,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "This is test product of our graduation project",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff989494),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "sport product to test the project.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff989494),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        height: 66,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          height: 66,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff9f91cc),
                                Color(0xff8471bb),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "Add to Cart\t\t\t\$120",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: dotIndex,
      count: images.length,
      onDotClicked: animateToSlide,
      effect: SlideEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: Color(0xff8471bb),
          dotColor: Colors.grey),
    );
  }

  void animateToSlide(int index) => carouselController.animateToPage(index);
}