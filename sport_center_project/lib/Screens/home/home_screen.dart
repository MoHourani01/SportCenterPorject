import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({Key? key}) : super(key: key);
  // final List<Color> colors = [    Colors.red,    Colors.orange,    Colors.yellow,    Colors.green,    Colors.blue,    Colors.purple,  ];
  final List<String> images=[ 'assets/images/Soccer.jpg', 'assets/images/basketball.jpg'];
  final List<String> texts=['Football', 'Basketball'];
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
            child: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  height: 250,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: PageView.builder(
                      itemCount: images.length,
                        itemBuilder: (context,index){
                          return Container(
                            margin: EdgeInsets.only(left: 15,right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                  image: AssetImage('${images[index % images.length]}'),
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
                          );
                        },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
