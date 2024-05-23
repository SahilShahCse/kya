// lib/providers/message_provider.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/message_model.dart';

class MessageProvider with ChangeNotifier {

  final String _userId = '0000';
  List<Message> _messages = [];

  late StreamSubscription<QuerySnapshot> _messagesSubscription;

  final CollectionReference _messagesCollection =
  FirebaseFirestore.instance.collection('messages');

  List<Message> get messages => _messages;
  get userId => _userId;

  MessageProvider() {
    _listenToMessages();
  }

  void _listenToMessages() {
    _messagesSubscription = _messagesCollection
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      _messages = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Message(
          id: doc.id,
          senderId: data['senderId'],
          text: data['text'],
          timestamp: (data['timestamp'] as Timestamp).toDate(),
        );
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addMessage(String text) async {
    final newMessage = Message(
      id: DateTime.now().toString(),
      text: text,
      timestamp: DateTime.now(),
      senderId: userId,
    );

    await _messagesCollection.add({
      'senderId': newMessage.senderId,
      'text': newMessage.text,
      'timestamp': newMessage.timestamp,
    });
    notifyListeners();
  }

}


