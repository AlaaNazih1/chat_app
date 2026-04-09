import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  

  const ChatBuble({super.key,required this.message});
final Message? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(message?.message ?? '', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ChatBubleForFrend extends StatelessWidget {
  

  const ChatBubleForFrend({super.key,required this.message});
final Message? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF006D84),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(message?.message ?? '', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
