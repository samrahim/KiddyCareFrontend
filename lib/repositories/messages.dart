import 'dart:async';
import 'package:babysitter/consts.dart';
import 'package:babysitter/models/message.model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatService {
  late io.Socket _socket;

  ChatService() {
    _socket = io.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();
  }
  void leaveRoom(int roomId) {
    _socket.emit('leaveroom', roomId);
  }

  StreamController<List<Message>> controller = StreamController();

  Stream<List<Message>> getChatMessages(int chatId) async* {
    // Create a StreamController to handle the stream of messages
    StreamController<List<Message>> controller = StreamController();

    // Listen for incoming chat messages from the server
    _socket.on('messages', (data) {
      final List<dynamic> responseData = data;
      List<Message> messages =
          responseData.map((json) => Message.fromJson(json)).toList();
      controller.add(messages);
    });

    _socket.emit('joinroom', chatId);
    yield* controller.stream;
  }

  void addMsg({
    required String messagebody,
    required String sender,
    required int chatRoomid,
  }) {
    print("shatroom id =======$chatRoomid");
    _socket.emit('sendmsg', {
      'message_body': messagebody,
      'sender': sender,
      'chatRoom_id': chatRoomid,
    });
  }
}
