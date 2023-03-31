import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sport_center_project/Screens/basketball/basketball_layout/basketball_screen.dart';
import 'package:sport_center_project/soccer/soccer_layout/soccer_screen.dart';

class BDetail extends StatefulWidget {
  const BDetail({Key? key}) : super(key: key);

  @override
  _BDetailState createState() => _BDetailState();
}

class _BDetailState extends State<BDetail> {
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
      color: isSeleted ? Colors.orangeAccent : Colors.white,
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
                                    builder: (context) => basket(),
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
                            IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.shopping_bag_rounded,
                                  color: Color(0xF717217A),
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
                          "basket ball",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
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
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Size",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // CircleAvatar(
                        //   radius: 15,
                        //   backgroundColor: Colors.brown,
                        // )
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
                                            ?  Color(0xF717217A)
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 15,
                        //       backgroundColor: Color(0xff317aaf),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 15,
                    //       backgroundColor: Color(0xfff19a9c),
                    //     )
                    //   ],
                    // ),
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
                                  color:Color(0xFF130359),
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
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "sport product to test the project.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade400,
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

                                Color(0xFF1D2EA8),
                                Color(0xFF130359),
                                Color(0xF717217A),
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
          activeDotColor:  Color(0xF717217A),
          dotColor: Colors.grey),
    );
  }

  void animateToSlide(int index) => carouselController.animateToPage(index);
}