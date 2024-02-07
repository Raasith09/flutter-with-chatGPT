import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Message> _messages = [];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    Message chatGpt = Message(
        text: "Hi, Myself chatGpt, How can i assist you today ?", isMe: false);
    _messages.insert(0, chatGpt);
    super.initState();
  }

  void onSendMessage() async {
    if (_textEditingController.text.isNotEmpty) {
      Message message = Message(text: _textEditingController.text, isMe: true);

      _textEditingController.clear();

      setState(() {
        _messages.insert(0, message);
      });

      String response = await sendMessageToChatGpt(message.text);

      Message chatGpt = Message(text: response, isMe: false);

      setState(() {
        _messages.insert(0, chatGpt);
      });
    }
  }

  Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 500,
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer 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",
      },
      body: json.encode(body),
    );

    Map<String, dynamic> parsedReponse = json.decode(response.body);

    String reply = parsedReponse['choices'][0]['message']['content'];

    return reply;
  }

  Widget _buildMessage(Message message) {
    return Container(
      decoration: BoxDecoration(
        color: message.isMe ? MyColors.primaryColor : MyColors.textfieldColor,
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isMe ? 'You' : 'ChatGPT',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: message.isMe ? MyColors.highLightColor : Colors.white,
                  fontSize: 12),
            ),
            const SizedBox(height: 5),
            Text(
              message.text,
              style: TextStyle(
                  fontSize: 14,
                  color: message.isMe ? Colors.grey : Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        elevation: 6,
        leading: Image.asset(
            "icons/eca7c76270caf43a128d8da759b40922-removebg-preview.png"),
        centerTitle: true,
        leadingWidth: 80,
        title: const Text(
          "ChatGpt +",
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _messages.clear();
                });
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            const SizedBox(height: 10),
            buildMessageInput(),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textEditingController,
            maxLines: null,
            textInputAction: TextInputAction.send,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(fontSize: 14, color: Colors.white),
            decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent)),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent)),
                hintText: 'Write your message',
                hintStyle: const TextStyle(
                    color: Color(0xff606173),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                contentPadding: const EdgeInsets.all(8),
                filled: true,
                fillColor: MyColors.textfieldColor),
          )),
          InkWell(
            onTap: onSendMessage,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: MyColors.secondColor, shape: BoxShape.circle),
              child: Center(
                child: Image.asset(
                  "icons/send.png",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
