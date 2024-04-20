import 'package:babysitter/models/message.model.dart';
import 'package:babysitter/repositories/messages.dart';
import 'package:flutter/material.dart';

class ParentDetailsChatScreen extends StatefulWidget {
  final int chatId;

  const ParentDetailsChatScreen({Key? key, required this.chatId})
      : super(key: key);

  @override
  _ParentDetailsChatScreen createState() => _ParentDetailsChatScreen();
}

class _ParentDetailsChatScreen extends State<ParentDetailsChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final chatroomservice = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              chatroomservice.leaveRoom(widget.chatId);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Chat Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: ChatService().getChatMessages(widget.chatId),
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
                        alignment: snapshot.data![index].sender == "Famille"
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
                        messagebody: messageController.text,
                        sender: "Famille",
                        chatRoomid: widget.chatId);
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
