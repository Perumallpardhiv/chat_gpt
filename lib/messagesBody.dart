import 'package:chatgpt/model.dart';
import 'package:flutter/material.dart';

class MessagesBody extends StatefulWidget {
  final String text;
  final ChatMessageType chatMessageType;

  MessagesBody({super.key, required this.text, required this.chatMessageType});

  @override
  State<MessagesBody> createState() => _MessagesBodyState();
}

class _MessagesBodyState extends State<MessagesBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      color: widget.chatMessageType == ChatMessageType.user
          ? Color(0xff343541)
          : Color(0xff444654),
      child: Row(
        children: [
          widget.chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/1.jpeg',
                      scale: 1.5,
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.person,
                    color: Colors.white, 
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: widget.chatMessageType == ChatMessageType.bot
                      ? Text(
                          widget.text.substring(2),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          widget.text,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
