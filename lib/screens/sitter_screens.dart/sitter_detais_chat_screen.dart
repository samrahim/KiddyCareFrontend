import 'package:babysitter/models/message.model.dart';
import 'package:babysitter/repositories/messages.dart';
import 'package:flutter/material.dart';

class SitterDetailsChatScreen extends StatefulWidget {
  final int chatId;

  const SitterDetailsChatScreen({Key? key, required this.chatId})
      : super(key: key);

  @override
  _SitterDetailsChatScreen createState() => _SitterDetailsChatScreen();
}

class _SitterDetailsChatScreen extends State<SitterDetailsChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final chatroomservice = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              chatroomservice.leaveRoom(widget.chatId, 3);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Chat Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: ChatService().getChatMessages(parentId: 1, sitterId: 2),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                } else {
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: snapshot.data![index].sender == "Sitter"
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Text(snapshot.data![index].messageBody),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    chatroomservice.addMsg(
                        messageBody: messageController.text,
                        sender: "Sitter",
                        parentId: widget.chatId,
                        sitterId: 2);
                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
