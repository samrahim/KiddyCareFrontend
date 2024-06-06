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

  void leaveRoom(int parentId, int sitterId) {
    String roomInfo = "$parentId$sitterId";
    _socket.emit('leaveroom', roomInfo);
  }

  Stream<List<Message>> getChatMessages({
    required int parentId,
    required int sitterId,
  }) async* {
    _socket.emit('joinRoom', {'parentId': parentId, 'sitterId': sitterId});

    StreamController<List<Message>> controller = StreamController();

    _socket.on('messages', (data) {
      final List<dynamic> responseData = data;
      List<Message> messages =
          responseData.map((json) => Message.fromJson(json)).toList();
      controller.add(messages);
    });

    yield* controller.stream;
  }

  void addMsg({
    required String messageBody,
    required String sender,
    required int parentId,
    required int sitterId,
  }) {
    _socket.emit('sendmsg', {
      "message_body": messageBody,
      "sender": sender,
      "parentId": parentId.toString(),
      "sitterId": sitterId.toString(),
    });
  }
}
