import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/message_provider.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4f1a31),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white70),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff4f1a31),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<MessageProvider>(
                builder: (context, messageProvider, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: messageProvider.messages.length,
                    itemBuilder: (context, index) {
                      final message = messageProvider.messages[index];
                      return Align(
                        alignment: message.senderId == messageProvider.userId
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: message.senderId == messageProvider.userId
                                ? Color(0xff3a1726)
                                : Color(0xff3a1726),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: message.senderId == messageProvider.userId? Radius.circular(0) : Radius.circular(15),
                              bottomLeft: message.senderId == messageProvider.userId? Radius.circular(15) : Radius.circular(0),
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: message.senderId == messageProvider.userId
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.text,
                                style: TextStyle(color: Colors.white70),
                              ),
                              Text(
                                message.timestamp.toString().substring(0, 16),
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff33111f),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextField(
                          style: TextStyle(color: Colors.white70),
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Let\'s Chat',
                            hintStyle: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff33111f),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          Provider.of<MessageProvider>(context, listen: false)
                              .addMessage(_controller.text);
                          _controller.clear();
                        }
                      },
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
}
