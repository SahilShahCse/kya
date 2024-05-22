import 'package:flutter/material.dart';
import 'package:kya/models/message_model.dart';
import 'package:provider/provider.dart';
import '../provider/message_provider.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatScreen({super.key});

  ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4f1a31),
      appBar: buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            buildTextMessageArea(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  buildTextFieldForMessage(),
                  const SizedBox(width: 5),
                  buildSendMessageIcon(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldForMessage() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff33111f),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(

            autocorrect: false,
            style: const TextStyle(color: Colors.white70),
            controller: _controller,
            decoration: const InputDecoration(
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
    );
  }

  Widget buildSendMessageIcon(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff33111f),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: const Icon(
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
    );
  }

  Widget buildTextMessageArea() {
    return Expanded(
      child: Consumer<MessageProvider>(
        builder: (context, messageProvider, child) {
          _scrollToBottom();
          return ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: messageProvider.messages.length,
            itemBuilder: (context, index) {
              final message = messageProvider.messages[index];
              return buildTextMessage(message, messageProvider);
            },
          );
        },
      ),
    );
  }

  Widget buildTextMessage(Message message, MessageProvider messageProvider) {
    return Align(
      alignment: message.senderId == messageProvider.userId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: message.senderId == messageProvider.userId ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
        children: [
          Container(
            decoration: BoxDecoration(
              color: message.senderId == messageProvider.userId
                  ? const Color(0xff3a1726)
                  : const Color(0xff3a1726),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomRight: message.senderId == messageProvider.userId
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
                bottomLeft: message.senderId == messageProvider.userId
                    ? const Radius.circular(15)
                    : const Radius.circular(0),
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: message.senderId == messageProvider.userId
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: const TextStyle(color: Colors.white70),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              message.timestamp.toString().substring(0, 16).replaceAll('-', '/').replaceAll(' ', '  '),
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.teal,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      title: const Text(
        'Chat',
        style: TextStyle(color: Colors.white70),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: const Color(0xff4f1a31),
    );
  }
}
