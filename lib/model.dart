enum ChatMessageType { user, bot }
class Chatmessage {
  final String text;
  final ChatMessageType chatMessageType;

  Chatmessage({
    required this.text,
    required this.chatMessageType,
  });
}
