import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sport_center_project/models/chat_model.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  // const ChatDetailsScreen({Key? key}) : super(key: key);

  ChatModel chatModel = ChatModel();

  List<Map<String, dynamic>> chatData = [];

  var textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadChatData();
  }

  void loadChatData() async {
    String data = await rootBundle.loadString('assets/intents.json');
    Map<String, dynamic> jsonData = json.decode(data);
    chatData = List<Map<String, dynamic>>.from(jsonData['intents']);
  }

  void handleSubmitted(String text) {
    textEditingController.clear();

    ChatMessage message = ChatMessage(
      text: text,
      isMe: true,
    );

    setState(() {
      if (text.isEmpty){
        return;
      }
      chatModel.addMessage(message);
    });

    String response = getChatbotResponse(text);

    ChatMessage botMessage = ChatMessage(
      text: response,
      isMe: false,
    );

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        if (text.isEmpty){
          return;
        }
        chatModel.addMessage(botMessage);
      });
    });
  }

  String getChatbotResponse(String text) {
    if (text.toLowerCase() == 'quit') {
      chatModel.clearMessages();
      return 'Chat ended. Goodbye!';
    }
    for (var i = 0; i < chatData.length; i++) {
      var data = chatData[i];
      var patterns = data['patterns'] as List<dynamic>;
      for (var j = 0; j < patterns.length; j++) {
        var pattern = patterns[j];
        if (text.toLowerCase().contains(pattern.toLowerCase())) {
          var responses = data['responses'] as List<dynamic>;
          return responses[getRandomIndex(responses.length)];
        }
      }
    }
    return "I'm sorry, I don't understand. Can you please rephrase your question?";
  }

  int getRandomIndex(int length) {
    return (DateTime.now().microsecond % length).toInt();
  }

  Widget _buildChatList() {
    return ListView.builder(
      itemCount: chatModel.messages.length,
      itemBuilder: (BuildContext context, int index) {
        final ChatMessage message = chatModel.messages[index];
        return Container(
          alignment:
              message.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: message.isMe ? Color(0xFF121879) : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
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
              SizedBox(
                width: 15.0,
              ),
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
      body: Column(
        children: [
          Expanded(
            child: _buildChatList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 8),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type a message',
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: handleSubmitted,
                    ),
                  ),
                  Container(
                    height: 50.0,
                    color: Colors.blue[900],
                    child: MaterialButton(
                      onPressed: () {
                        handleSubmitted(textEditingController.text);
                        textEditingController.clear();
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
          ),
        ],
      ),
    );
  }
}