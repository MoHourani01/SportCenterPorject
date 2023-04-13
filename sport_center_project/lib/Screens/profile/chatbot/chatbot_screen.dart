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

  Future<void> _sendMessage() async {
    String message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
      // Make an HTTP request to the Flask server
      String url = 'https://a6de-176-29-95-202.eu.ngrok.io/predict';
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({'message': message});
      http.Response response = await http.post(Uri.parse(url), headers: headers, body: body);

      // Process the response from the Flask server
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        if (data is List) {
          // The response is an array of results
          if (data.isNotEmpty) {
            Map<String, dynamic> result = data[0];
            if (result['intent'] != null && result['probability'] != null) {
              String intent = result['intent'];
              String probability = result['probability'];
              _addMessage('You: $message');
              _addMessage('Bot: $intent (probability: $probability)');
            } else {
              _addMessage('Error: Invalid response from server');
              print(response.body);
            }
          } else {
            _addMessage('Error: Empty response from server');
            print(response.body);
          }
        } else if (data is Map) {
          // The response is a single result
          if (data['intent'] != null && data['probability'] != null) {
            String intent = data['intent'];
            String probability = data['probability'];
            _addMessage('You: $message');
            _addMessage('Bot: $intent (probability: $probability)');
          } else {
            _addMessage('Error: Invalid response from server');
            print(response.body);
          }
        } else {
          // The response is not in the expected format
          _addMessage('Error: Invalid response from server');
          print(response.body);
        }
      } else {
        _addMessage('Error: ${response.reasonPhrase}');
        print(response.body);
      }


      _textEditingController.clear();
    }
  }

  void _addMessage(String message) {
    setState(() {
      _messages.add(message);
    });
  }

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
                      onSubmitted: (_) => _sendMessage(),
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
                        _sendMessage();
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