import 'package:chatgpt/apifetch.dart';
import 'package:chatgpt/messagesBody.dart';
import 'package:chatgpt/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class chatscreen extends StatefulWidget {
  const chatscreen({super.key});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  var isLoading = false;
  TextEditingController controller = TextEditingController();
  var scrollController = ScrollController();
  List<Chatmessage> messages = [];

  ScrollMethod() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff343541),
      appBar: AppBar(
        backgroundColor: Color(0xff444654),
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "CHAT-GPT",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              shrinkWrap: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var msg = messages[index];
                return MessagesBody(
                  text: msg.text,
                  chatMessageType: msg.chatMessageType,
                );
              },
            ),
          ),
          Visibility(
            visible: isLoading,
            child: SpinKitThreeBounce(
              color: Colors.white,
              size: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      fillColor: Color(0xff444654),
                      filled: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Visibility(
                  child: Container(
                    color: Color(0xff444654),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.grey,
                      ),
                      onPressed: () async {
                        setState(
                          () {
                            messages.add(
                              Chatmessage(
                                text: controller.text,
                                chatMessageType: ChatMessageType.user,
                              ),
                            );
                            isLoading = true;
                          },
                        );
                        var input = controller.text;
                        controller.clear();
                        Future.delayed(const Duration(milliseconds: 50))
                            .then((_) => ScrollMethod());
                        var output = await fetchFromAPI.sendMsg(input);
                        setState(() {
                          isLoading = false;
                          messages.add(
                            Chatmessage(
                              text: output,
                              chatMessageType: ChatMessageType.bot,
                            ),
                          );
                        });
                        Future.delayed(const Duration(milliseconds: 50))
                            .then((_) => ScrollMethod());
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
