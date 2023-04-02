import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  List<ChatMessage> _messages = <ChatMessage>[];
  String _botResponse = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kore.ai Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true, // To keep the latest message at the bottom
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _controller,
                onSubmitted: _handleSubmitted,
                decoration:
                InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_controller.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _controller.clear();
    ChatMessage message = ChatMessage(
      text: text,
      sender: 'user',
      type: MessageType.sent,
    );
    setState(() {
      _messages.insert(0, message);
    });
    _getBotResponse(text);
  }

  void _getBotResponse(String text) async {
    final response = await http.post(
      Uri.parse('https://bots.kore.ai/api/v1.1/rest/webhook/st-5a13bbb4-f709-5115-9bfa-640d11d8424e'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer st-5a13bbb4-f709-5115-9bfa-640d11d8424e',
      },
      body: jsonEncode(<String, dynamic>{
        'event': 'message',
        'context': {'timezone': 'UTC', 'channel': 'flutter'},
        'data': {'text': text},
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _botResponse = data['message'];
        ChatMessage message = ChatMessage(
          text: _botResponse,
          sender: 'bot',
          type: MessageType.received,
        );
        _messages.insert(0, message);
      });
    } else {
      throw Exception('Failed to load bot response');
    }
  }

}

enum MessageType { sent, received }
class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;
  final MessageType type;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.sender,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            child: Text(sender[0]),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                sender,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge,
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



//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
//st-5a13bbb4-f709-5115-9bfa-640d11d8424e