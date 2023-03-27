import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_center_project/Utilities/VariablesUtils.dart';
import 'package:sport_center_project/models/login_model.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  // ImagePicker picker = ImagePicker();

  // File? imageFile;
  //
  // String subjectImageUrl = '';

  //final FilesUploadService _filesUploadService = FilesUploadService();

  //final ProfileService _profileService = ProfileService();

  // final List<IconData> icons=[
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF130359).withOpacity(0.8),
      ),
      body: Column(
        children: [
          SizedBox(
            // height: 175.0,
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 200.0,
                    color:  Color(0xFF130359).withOpacity(0.8),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 60.0,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 65.0,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(VariablesUtils
                                    .imageUrl !=
                                    ''
                                    ? VariablesUtils.imageUrl
                                    : 'https://img.freepik.com/free-photo/portrait-young-girl-red-beret-painting-her-lips-with-bright-lipstick-pink-background_197531-17567.jpg'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 60.0,
                            ),
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.blueGrey.shade700,
                              child: IconButton(
                                onPressed: () async {
                                  // await chooseSubjectImage(ImageSource.gallery);
                                  // if (imageFile != null) {
                                  //   subjectImageUrl = await _filesUploadService
                                  //       .fileUpload(imageFile!, 'UsersImage')
                                  //       .then((value) async {
                                  //     if (value != '') {
                                  //       var model = UserModel(
                                  //         uid: VariablesUtils.uid,
                                  //         email: VariablesUtils.email,
                                  //         userType: VariablesUtils.userType,
                                  //         rePassword: VariablesUtils.password,
                                  //         userName: VariablesUtils.userName,
                                  //         imageUrl: value,
                                  //         loginState: VariablesUtils.loginState,
                                  //         password: VariablesUtils.password,
                                  //         phone: VariablesUtils.phone,
                                  //         state: VariablesUtils.state,
                                  //       );
                                  //
                                  //       await _profileService.updateProfile(
                                  //           VariablesUtils.uid, model);
                                  //       VariablesUtils.imageUrl = value;
                                  //       setState(() {});
                                  //       log(VariablesUtils.imageUrl);
                                  //     } else {
                                  //       log('cant do this');
                                  //     }
                                  //     return '';
                                  //   });
                                  // }
                                },
                                icon: Icon(
                                  Icons.settings,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        VariablesUtils.userName,
                        style: TextStyle(
                          // fontFamily: 'Georgia',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: ListTile(
                        //       trailing: Icon(
                        //         Icons.navigate_next,
                        //       ),
                        //       title: Text('Payment'),
                        //       leading: Icon(Icons.payment_outlined),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        ),
                        VariablesUtils.userType == 'vendor'
                            ? Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              // mUtils.navigatorWithBack(
                              //     context, AdminDashboard());
                            },
                            child: ListTile(
                              trailing: Icon(
                                Icons.navigate_next,
                              ),
                              title: Text('insights'),
                              leading: Icon(
                                  Icons.insert_chart_outlined_outlined),
                            ),
                          ),
                        )
                            : Container(),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade300,
                        //     borderRadius: BorderRadius.circular(30.0),
                        //   ),
                        //   child: InkWell(
                        //     onTap: () {
                        //       // navigateTo(context, MyOrdersScreen());
                        //     },
                        //     child: ListTile(
                        //       trailing: Icon(
                        //         Icons.navigate_next,
                        //       ),
                        //       title: Text('My Orders'),
                        //       leading: Icon(Icons.shopping_cart_outlined),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        VariablesUtils.userType == 'vendor'
                            ? SizedBox(
                          height: 10,
                        )
                            : SizedBox(
                          height: 0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () async {
                              // Uri callUrl = Uri.parse('tel:=0791234567');
                              // if (await canLaunchUrl(callUrl)) {
                              //   await launchUrl(callUrl);
                              // } else {
                              //   throw 'Could not open the dialler.';
                              // }
                              // navigateTo(context, MyOrdersScreen());
                            },
                            child: ListTile(
                              trailing: Icon(
                                Icons.navigate_next,
                              ),
                              title: Text('Chat Bot'),
                              leading: Icon(Icons.chat_bubble),
                              iconColor:Colors.blueGrey.shade900 ,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              trailing: Icon(
                                Icons.navigate_next,
                              ),
                              title: Text('About us'),
                              leading: Icon(Icons.chat),
                              iconColor: Colors.blueGrey.shade900,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              // _userService
                              //     .logout()
                              //     .then((value) =>
                              //     mUtils.navigator(context, LoginScreen()))
                              //     .whenComplete(() {
                              //   Fluttertoast.showToast(msg: 'Logged out');
                              // });
                            },
                            child: ListTile(
                              trailing: Icon(
                                Icons.navigate_next,
                              ),
                              title: Text('Logout'),
                              leading: Icon(Icons.logout),
                              iconColor: Colors.red.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  // chooseSubjectImage(ImageSource source) async {
  //   final pickedFile = await picker.pickImage(source: source);
  //   if (pickedFile!.path.isEmpty) {
  //     retrieveLostData();
  //   } else {
  //     setState(() {
  //       // imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  // Future<void> retrieveLostData() async {
  //   final LostData response = await picker.getLostData();
  //   if (response.file != null) {
  //     setState(() {
  //       imageFile = File(response.file!.path);
  //     });
  //   } else {
  //     // log('response.file : ${response.file}');
  //   }
  // }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 120);
    path.quadraticBezierTo(width / 2, height, width, height - 120);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
