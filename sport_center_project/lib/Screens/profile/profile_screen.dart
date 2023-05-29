import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_center_project/Screens/profile/about_us.dart';
import 'package:sport_center_project/Screens/profile/add_products_admin/add_products_admin.dart';
import 'package:sport_center_project/Screens/profile/chatbot/chatbot_screen.dart';
import 'package:sport_center_project/Screens/profile/profile_services/profile_services.dart';
import 'package:sport_center_project/Screens/profile/reports/reports_screen.dart';
import 'package:sport_center_project/Utilities/VariablesUtils.dart';
import 'package:sport_center_project/models/login_model.dart';
import 'package:sport_center_project/registration/login/login_cubit/login_cubit.dart';
import 'package:sport_center_project/registration/login/login_screen.dart';
import 'package:sport_center_project/shared/component/component.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String defaultImage = 'https://images-platform.99static.com/eEgFxdpfqm4mxTjtP7d5mcBqDUE=/203x203:1829x1829/500x500/top/smart/99designs-contests-attachments/124/124195/attachment_124195589';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.blueGrey,
      //     child: Icon(Icons.add),
      //     tooltip: 'Bottom sheet',
      //     onPressed: () {
      //       if (VariablesUtils.userName == 'test') {
      //         _showBottomSheet(context);
      //       } else {
      //         Fluttertoast.showToast(
      //             msg: 'Sorry you are not Admin');
      //       }
      //     }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'My Profile',
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
                Color(0xFF030A59),
                Color(0xFF121879),
                Color(0xFF2931A8),
              ],
              begin: AlignmentDirectional.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 50.0,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70.0,
                            child: CircleAvatar(
                              radius: 65.0,
                              backgroundImage:
                              NetworkImage('${defaultImage}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${VariablesUtils.prefs.getString('name')}',
                      style: TextStyle(
                        // fontFamily: 'Georgia',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xF70A2991),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
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
                        ),
                        if( VariablesUtils.userName == 'Admin')
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                onTap: () {
                                  navigators.navigatorWithBack(
                                      context, AddProductsScreen());
                                },
                                trailing: Icon(
                                  Icons.navigate_next,
                                ),
                                title: Text('Add Product'),
                                leading: Icon(Icons.add),
                                iconColor: Colors.blueGrey.shade900,
                              ),
                            ),
                          ),
                        SizedBox(height: 10,),
                        if( VariablesUtils.userName == 'Admin')
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                onTap: () {
                                  navigators.navigatorWithBack(
                                      context, ReportsScreen());
                                },
                                trailing: Icon(
                                  Icons.navigate_next,
                                ),
                                title: Text('Reports'),
                                leading: Icon(Icons.report_gmailerrorred),
                                iconColor: Colors.blueGrey.shade900,
                              ),
                            ),
                          ),
                        SizedBox(height: 10,),
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
                              navigators.navigatorWithBack(
                                  context, ChatbotScreen());
                            },
                            child: ListTile(
                              trailing: Icon(
                                Icons.navigate_next,
                              ),
                              title: Text('Chat Bot'),
                              leading: Icon(Icons.chat_bubble),
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
                            onTap: () {},
                            child: ListTile(
                              onTap: () {
                                navigators.navigatorWithBack(
                                    context, about());
                              },
                              trailing: Icon(
                                Icons.navigate_next,
                              ),
                              title: Text('About us'),
                              leading: Icon(Icons.question_mark_sharp),
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
                            },
                            child: ListTile(
                              onTap: () {
                                LoginCubit.get(context)
                                    .logout()
                                    .then((value) =>
                                    navigators.navigateTo(
                                        context, LoginScreen()))
                                    .whenComplete(() =>
                                    showToast(
                                        text: 'Logged out',
                                        state: ToastStates.Success));
                              },
                              trailing: Icon(
                                Icons.navigate_next,
                              ),
                              title: Text('Logout'),
                              leading: Icon(Icons.logout),
                              iconColor: Colors.red.shade900,
                            ),
                          ),
                        ),SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () {

                            },
                            child: ListTile(
                              onTap: () {
                                  LoginCubit.get(context)
                                      .deleteAccount()
                                      .then((value) =>
                                      navigators.navigateTo(
                                          context, LoginScreen()))
                                      .whenComplete(() =>
                                      showToast(
                                          text: 'Account Deleted Successfully',
                                          state: ToastStates.Success));
                              },
                              trailing: Icon(
                                Icons.navigate_next,
                              ),
                              title: Text('Delete Account'),
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
}



