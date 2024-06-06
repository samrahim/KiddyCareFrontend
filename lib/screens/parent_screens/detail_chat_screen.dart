import 'package:babysitter/models/message.model.dart';
import 'package:babysitter/repositories/messages.dart';
import 'package:flutter/material.dart';

class ParentDetailsChatScreen extends StatefulWidget {
  final int parentId;
  final int sitterId;
  final String sitterName;
  final String imagePath;
  const ParentDetailsChatScreen(
      {Key? key,
      required this.parentId,
      required this.imagePath,
      required this.sitterId,
      required this.sitterName})
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
              chatroomservice.leaveRoom(widget.parentId, widget.sitterId);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Row(
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(widget.imagePath, fit: BoxFit.cover),
                )),
            Text(
              '  ${widget.sitterName}',
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: ChatService().getChatMessages(
                    parentId: widget.parentId, sitterId: widget.sitterId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
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
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                snapshot.data![index].messageBody,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              )),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 2),
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
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade400, width: 1.5)),
                        hintText: 'type message',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      chatroomservice.addMsg(
                          messageBody: messageController.text,
                          sender: "Famille",
                          parentId: widget.parentId,
                          sitterId: widget.sitterId);
                      messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
