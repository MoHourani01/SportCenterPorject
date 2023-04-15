import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sport_center_project/Screens/search/3.dart';
import 'package:sport_center_project/Screens/search/2.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  var inputText = "";
  final TextEditingController _search2 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff00967c)),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(colors: [
                          Colors.white,
                          Colors.white,

                        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      ),
                      child: Column(children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                              color: Color(0xff00967c),
                            ),
                            SizedBox(
                              width: 270,
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    inputText = val;
                                    print(inputText);
                                  });
                                },
                                controller: _search2,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Color(0xff00967c),
                                      size: 28,
                                    ),
                                    onPressed: () {},
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.keyboard_voice_sharp,color: Color(0xff00967c),),
                                    onPressed: () {},
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: 'Search Products',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff00967c), width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff00967c), width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // _buildSearchFld(),
                      ]),
                    ),
                  ),
                ],
              )),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('books')
                    .where('subjectName', isLessThanOrEqualTo: inputText)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Something went wrong ",
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading"),
                    );
                  }
                  return ListView(
                    children:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                      return SubjectView(
                        bookName: data['subjectName'],
                        writerName: data['writerName'],
                        image: data['image'],
                        ontap: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomDialog(
                                description: data['description'],
                                title: 'Description',
                                image: 'assets/images/Soccer.jpg',
                              ));
                        },
                        fileUrl: data['FileModel']['url'],
                        downLoadUrl: () {
                          downLoadFile(data['FileModel']['url'],
                              data['FileModel']['name']);
                        },
                        createdDate: data['FileModel']['createdDate'],
                      );
                    }).toList(),
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<File?> downLoadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: Duration(seconds: 0),
          ));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      OpenAppFile.open(file.path);

      return file;
    } catch (e) {
      return null;
    }
  }
}