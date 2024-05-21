// lib/providers/message_provider.dart
import 'package:flutter/foundation.dart';
import '../models/message_model.dart';

class MessageProvider with ChangeNotifier {

  String _userId = '0000';
  List<Message> _messages = [];

  List<Message> get messages => _messages;
  get userId => _userId;

  void addMessage(String text) {
    final newMessage = Message(
      id: DateTime.now().toString(),
      text: text,
      timestamp: DateTime.now(),
      senderId: userId,
    );
    _messages.add(newMessage);
    notifyListeners();
  }

}
