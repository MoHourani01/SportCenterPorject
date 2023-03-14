import 'package:flutter/material.dart';

class CategoriesInfo extends StatefulWidget {
  const CategoriesInfo({Key? key}) : super(key: key);

  @override
  State<CategoriesInfo> createState() => _CategoriesInfoState();
}

class _CategoriesInfoState extends State<CategoriesInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    // color: Colors.green,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/Soccer.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text('Soccer Category',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    // color: Colors.green,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/basketball.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text('Basketball Category',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

