import 'package:flutter/material.dart';

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

  int indexItems = 0;

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
                  Container(
                    height: 220,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: PageView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      '${images[index % images.length]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Text(
                                '${texts[index]}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
                                        : Colors.blueGrey.shade900.withOpacity(1),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        primary: false,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage('assets/images/Soccer.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage('assets/images/Soccer.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage('assets/images/Soccer.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage('assets/images/Soccer.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
