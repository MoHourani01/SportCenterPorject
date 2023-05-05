class ChatModel {
  List<ChatMessage> messages = [];

  void addMessage(ChatMessage message) {
    messages.add(message);
  }
  void clearMessages() {
    messages.clear();
  }
}
class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.isMe,
  });
}