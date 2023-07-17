import 'package:chatgpt_api/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessagesBody extends StatefulWidget {
  final String text;
  final ChatMessageType chatMessageType;

  MessagesBody({super.key, required this.text, required this.chatMessageType});

  @override
  State<MessagesBody> createState() => _MessagesBodyState();
}

class _MessagesBodyState extends State<MessagesBody> {
  IconData icn = Icons.copy;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      color: widget.chatMessageType == ChatMessageType.user
          ? const Color(0xff343541)
          : const Color(0xff444654),
      child: Row(
        children: [
          widget.chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    child: Image.asset(
                      'assets/1.jpeg',
                      scale: 1.5,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: widget.chatMessageType == ChatMessageType.bot
                      ? SelectableText(
                          widget.text.length <= 2
                              ? widget.text
                              : widget.text == "Failed to Fetch Data"
                                  ? widget.text
                                  : widget.text.substring(2),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          toolbarOptions:
                              const ToolbarOptions(copy: true, selectAll: true),
                        )
                      : SelectableText(
                          widget.text,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          toolbarOptions:
                              const ToolbarOptions(copy: true, selectAll: true),
                        ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              icn,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                icn = Icons.check;
              });
              Future.delayed(const Duration(milliseconds: 1000)).then((value) {
                icn = Icons.copy;
              });
              final value = widget.chatMessageType == ChatMessageType.user
                  ? ClipboardData(text: widget.text)
                  : ClipboardData(
                      text: widget.text.length <= 2
                          ? widget.text
                          : widget.text.substring(2),
                    );
              Clipboard.setData(value);
            },
          ),
        ],
      ),
    );
  }
}
