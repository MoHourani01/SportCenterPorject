import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class flipWidget{
  final String image;

  flipWidget({
    required this.image,
  });
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({Key? key}) : super(key: key);
  // final List<Color> colors = [    Colors.red,    Colors.orange,    Colors.yellow,    Colors.green,    Colors.blue,    Colors.purple,  ];
  final List<String> images = [
    'assets/images/Soccer.jpg',
    'assets/images/basketball.jpg'
  ];
  final List<String> texts = ['Football', 'Basketball'];
  final List<String> items = ['All', 'Shoes', 'Shirts', 'Equipments', 'Balls'];

  List<flipWidget> flipper=[
    flipWidget(
      image: 'assets/images/Soccer.jpg',),
    flipWidget(
      image: 'assets/images/Soccer.jpg',),
    flipWidget(
      image: 'assets/images/Soccer.jpg',),
  ];

  final carouselController = CarouselController();

  int indexItems = 0;

  int activatedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            elevation: 0,
            // expandedHeight: 200,
            backgroundColor: Color(0xFF130359),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Sport Center',
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF130359),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
              ),
              title: Text('Sport Center'),
              centerTitle: true,
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   height: 220,
                  //   margin: EdgeInsets.only(left: 20, right: 20),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade300,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(12.0),
                  //     child: PageView.builder(
                  //       itemCount: images.length,
                  //       itemBuilder: (context, index) {
                  //         return InkWell(
                  //           onTap: () {},
                  //           child: Container(
                  //             margin: EdgeInsets.only(left: 15, right: 15),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(20.0),
                  //               image: DecorationImage(
                  //                 image: AssetImage(
                  //                     '${images[index % images.length]}'),
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //             child: Text(
                  //               '${texts[index]}',
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 20,
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  CarouselSlider(
                      items: images.map((e) => Image(
                        image: AssetImage('${e}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),).toList(),
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
                        onPageChanged: (index,reason)=>
                            setState(()=> activatedIndex=index),
                      ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  buildIndicator(),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < items.length; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexItems = i;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: indexItems == i
                                        ? Color(0xFF320C72).withOpacity(1)
                                        : Colors.white70,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  items[i],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: items[i] == items[indexItems]
                                        ? Colors.white
                                        : Colors.blueGrey.shade900
                                            .withOpacity(1),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15, right: 15),
                  //   child: GridView.count(
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 10,
                  //     mainAxisSpacing: 10,
                  //     shrinkWrap: true,
                  //     primary: false,
                  //     children: [
                  //       FlipCard(
                  //         fill: Fill.fillFront,
                  //         // Fill the back side of the card to make in the same size as the front.
                  //         direction: FlipDirection.HORIZONTAL,
                  //         // default
                  //         side: CardSide.FRONT,
                  //         // The side to initially display.
                  //         front:  Card(
                  //           elevation: 3,
                  //           shape: RoundedRectangleBorder(
                  //             side: BorderSide(
                  //               color: Theme.of(context).colorScheme.outline,
                  //             ),
                  //             borderRadius:
                  //             const BorderRadius.all(Radius.circular(6)),
                  //           ),
                  //           child: Container(
                  //             height: 160,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(6.0),
                  //                 image: DecorationImage(
                  //                     image:
                  //                     AssetImage('assets/images/Soccer.jpg'),
                  //                     fit: BoxFit.cover)),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.end,
                  //               children: [
                  //                 ClipRRect(
                  //                   borderRadius: BorderRadius.circular(6.0),
                  //                   child: BackdropFilter(
                  //                     filter: ImageFilter.blur(
                  //                         sigmaX: 7.0, sigmaY: 7.0),
                  //                     child: Container(
                  //                         height: 36,
                  //                         width: double.infinity,
                  //                         decoration: BoxDecoration(
                  //                             color:
                  //                             Colors.black.withOpacity(0.3)),
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               left: 10, bottom: 3),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                             children: [
                  //                               Row(
                  //                                 crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                                 children: [
                  //                                   InkWell(
                  //                                     onTap: () {},
                  //                                     child: Icon(
                  //                                       Icons.favorite_border,
                  //                                       color: Colors.white,
                  //                                     ),
                  //                                   ),
                  //                                   Padding(
                  //                                     padding:
                  //                                     const EdgeInsets.only(
                  //                                         left: 37,
                  //                                         right: 15),
                  //                                     child: InkWell(
                  //                                       onTap: (){},
                  //                                       child: Text(
                  //                                         'Price JD',
                  //                                         style: const TextStyle(
                  //                                             color: Colors.white,
                  //                                             fontWeight:
                  //                                             FontWeight.w600),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         )),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         back: Card(
                  //           elevation: 0,
                  //           shape: RoundedRectangleBorder(
                  //             side: BorderSide(
                  //               color: Theme.of(context).colorScheme.outline,
                  //             ),
                  //           ),
                  //           child: Container(
                  //             height: 160,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10.0),
                  //               color: Colors.grey,
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 'Sport Center',
                  //                 style: TextStyle(
                  //                   fontSize: 22,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: PageView.builder(
                      itemCount: flipper.length,
                      itemBuilder: (context,index)=> cardFlippers(flipper[index]),
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
  /// ToDo Mahmoud
  Widget cardFlippers(flipWidget flip){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        primary: false,
        children: [
          FlipCard(
            fill: Fill.fillFront,
            // Fill the back side of the card to make in the same size as the front.
            direction: FlipDirection.HORIZONTAL,
            // default
            side: CardSide.FRONT,
            // The side to initially display.
            front:  Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius:
                const BorderRadius.all(Radius.circular(6)),
              ),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                        image:
                        AssetImage('${flip.image}'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 7.0, sigmaY: 7.0),
                        child: Container(
                            height: 36,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:
                                Colors.black.withOpacity(0.3)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 37,
                                            right: 15),
                                        child: InkWell(
                                          onTap: (){},
                                          child: Text(
                                            'Price JD',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            back: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                ),
                child: Center(
                  child: Text(
                    'Sport Center',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(){
    return AnimatedSmoothIndicator(
      activeIndex: activatedIndex,
      count: images.length,
      onDotClicked: animateToSlide,
      effect: SlideEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: Colors.blue.shade900.withOpacity(1),
        dotColor: Colors.grey
      ),
    );
  }

  void animateToSlide(int index)=> carouselController.animateToPage(index);
}

