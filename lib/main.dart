// lib/main.dart
import 'package:flutter/material.dart';
import 'package:kya/provider/message_provider.dart';
import 'package:provider/provider.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageProvider()),
      ],
      child: MaterialApp(
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChatScreen(),
      ),
    );
  }
}
