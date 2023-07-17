import 'package:chatgpt_api/apifetch.dart';
import 'package:chatgpt_api/messagesBody.dart';
import 'package:chatgpt_api/model.dart';
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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        backgroundColor: const Color(0xff444654),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "CHAT-GPT",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
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
            child: const SpinKitThreeBounce(
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
                    decoration: const InputDecoration(
                      fillColor: Color(0xff444654),
                      filled: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Visibility(
                  visible: !isLoading,
                  child: Container(
                    color: const Color(0xff444654),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.grey,
                      ),
                      onPressed: () async {
                        if (controller.text != "") {
                          setState(() {
                            messages.add(
                              Chatmessage(
                                text: controller.text,
                                chatMessageType: ChatMessageType.user,
                              ),
                            );
                            isLoading = true;
                          });
                          var input = controller.text
                              .replaceAll('.', '')
                              .replaceAll('!', '')
                              .toLowerCase();
                          controller.clear();
                          Future.delayed(const Duration(milliseconds: 50)).then(
                            (_) => ScrollMethod(),
                          );
                          var output = await fetchFromAPI.sendMsg(input);
                          setState(() {
                            isLoading = false;
                            messages.add(
                              output == null
                                  ? Chatmessage(
                                      text: "Failed to Fetch Data",
                                      chatMessageType: ChatMessageType.bot,
                                    )
                                  : Chatmessage(
                                      text: output,
                                      chatMessageType: ChatMessageType.bot,
                                    ),
                            );
                          });
                          Future.delayed(const Duration(milliseconds: 50)).then(
                            (_) => ScrollMethod(),
                          );
                        }
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
