import 'package:chat_app_get/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MessageBubble extends StatefulWidget {
  final MessageModel message;
  final String username;
  final bool isMe;

  const MessageBubble(
      {Key? key,
      required this.message,
      required this.username,
      required this.isMe})
      : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    /*String id;
  String text;
  UserModel sender;
  DateTime createdAt;
  List<UserModel> seenBy;
  String? imageUrl;*/
    if (FirebaseAuth.instance.currentUser!.uid == widget.message.sender.id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment: widget.message.sender.id == widget.username
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message.sender.name,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                Text(
                  widget.message.text,
                  style: TextStyle(
                    color: widget.isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.titleMedium!.color,
                    fontSize: 15,
                  ),
                  textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
                ),
                Text(
                  "${widget.message.createdAt.hour}:${widget.message.createdAt.minute}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade400,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  widget.message.createdAt.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
