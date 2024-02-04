import 'package:chat_app/index.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uuid/uuid.dart';
import 'package:lottie/lottie.dart';


class ChatProvider extends ChangeNotifier {
  // Named constructor to receive the Hive box

  // Final variable, initialized in the constructor

  String _chatId = "";
  String get chatId => _chatId;
  List<Map<String, String>> convo = []; // Initialize convo with an empty list
  List<Widget> _messages = [];
  List<Widget> get messages => _messages;
  bool _textField = true;
  bool get textField => _textField;
  bool _obsecure = true;
  bool _loading = false;
  bool get obsecure => _obsecure;
  bool get loading => _loading;

  void addMessage(String message, String role, chatIds) async {
    String? response;
    bool newChat;

    await switchTextField();
    convo.isEmpty ? newChat = true : newChat = false;

    newChat == true ? _chatId = await generateChatId() : _chatId = chatIds;

    convo.add({"role": role, "parts": message});
    convo.add({"role": "Loading", "parts": "Loading"});
    setMessages(convo, _chatId);
    notifyListeners();
    convo.removeLast();
    try {
      response = await AI(conversation: convo).getAnswer();
    } catch (e) {
      response = e.toString();
    }
    ;

    response != null
        ? convo.add({"role": "model", "parts": response})
        : convo.add({"role": "model", "parts": "Internal Error!"});

    Hive.box("convo").put(_chatId, convo);

    await switchTextField();
    setMessages(convo, chatId); // Update message widgets
  }

  setMessages(conversation, chatIds, {bool animate = false}) {
    _messages = []; // Clear the list before rebuilding
    _chatId = chatIds;
    print(_chatId);
    convo = conversation as List<Map<String, String>>;
    for (var msg in conversation) {
      String message = msg["parts"] as String;
      String role = msg["role"] as String;
      _messages.insert(
          0,
          SliverToBoxAdapter(
              child: MessageComponent(
            message: message,
            isMe: role,
            animate: animate,
          )));
    }

    notifyListeners();
  }

  void reset() {
    _messages = [];
    convo = [];
    _chatId = "";

    setMessages(convo, chatId);
    notifyListeners();
  }

  switchTextField() {
    _textField == true ? _textField = false : _textField = true;
    notifyListeners();
  }

  switchObsecure() {
    _obsecure == true ? _obsecure = false : _obsecure = true;
    notifyListeners();
  }

  switchLoading() {
    _loading == true ? _loading = false : _loading = true;
    notifyListeners();
  }

  String generateChatId() {
    var uuid = Uuid(); // Create a UUID object
    var chatId = uuid.v4(); // Generate a version 4 UUID (random)
    return chatId; // Return the generated chat ID as a string
  }

  void deleteConvo(chatId) {
    Hive.box("convo").delete(chatId.toString());
    reset();
  }
}

class MessageComponent extends StatelessWidget {
  final String message;
  final String isMe;
  bool? animate = false;

  MessageComponent({
    Key? key,
    required this.message,
    required this.isMe,
    this.animate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe == "user" ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Animate(
          child: IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(maxWidth: 300, minWidth: 70),
              transformAlignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: isMe == "user" ? Colors.grey.shade400 : Colors.black,
                borderRadius: isMe == "user"
                    ? BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(0))
                    : BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(15)),
              ),
              child: isMe == "Loading"
                  ? Container(
                      width: 300,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey.shade400,
                        color: Colors.black,
                        borderRadius: BorderRadius.horizontal(),
                      ))
                  : Animate(
                      effects: [FadeEffect(), AlignEffect()],
                      child: SelectableText(
                        message,
                        style: TextStyle(
                            color: isMe == "user"
                                ? Colors.black
                                : Colors.grey.shade200),
                      ),
                    ),
            ),
          ),
        ).fadeIn(
            duration: Duration(
          seconds: animate == true ? 1 : 0,
        )),
      ),
    );
  }
}
