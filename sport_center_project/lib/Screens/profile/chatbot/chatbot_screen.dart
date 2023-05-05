import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ChatbotScreen extends StatefulWidget {
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  // const ChatDetailsScreen({Key? key}) : super(key: key);
  var _textEditingController = TextEditingController();

  List<String> _messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('assets/images/chatbott.jpg'),
              ),
              SizedBox(width: 15.0,),
              Text('Chatbot'),
            ],
          ),
        ),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // buildMessage(),
            // buildMyMessage(),
            // Spacer(),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  // var message=SocialCubit.get(context).messages[index];
                  // if(SocialCubit.get(context).socialUserModel!.uId==message.senderId)
                  //   return buildMyMessage();
                  return buildMessage(_messages[index]);
                },
                separatorBuilder:(context, index) => SizedBox(height: 15.0,),
                itemCount: _messages.length,
              ),
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0,),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type a message',
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_){

                      },
                    ),
                  ),
                  Container(
                    height: 50.0,
                    color: Colors.blue[900],
                    child: MaterialButton(
                      onPressed: () {
                        // SocialCubit.get(context).sendMessage(
                        //   receiverId: userModel!.uId!,
                        //   dateTime: DateTime.now().toString(),
                        //   text: messageController.text,
                        //   }
                        // )
                        // messageController.text='';
                        // _sendMessage();
                        _textEditingController.clear();
                      },
                      child: Icon(
                        Icons.send,
                        size: 16.0,
                        color: Colors.white,
                      ),
                      minWidth: 1.0,
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

  Widget buildMessage(String message)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0,),
          topStart: Radius.circular(10.0,),
          topEnd: Radius.circular(10.0,),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        '$message',
      ),
    ),
  );

  Widget buildMyMessage(String message) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue[900]?.withOpacity(0.3),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0,),
          topStart: Radius.circular(10.0,),
          topEnd: Radius.circular(10.0,),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        '$message',
      ),
    ),
  );
}