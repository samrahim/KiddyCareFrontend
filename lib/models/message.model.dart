class Message {
  final int id;
  final String messageBody;
  final String sender;
  final int chatroomId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.messageBody,
    required this.sender,
    required this.chatroomId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Message object from a JSON map
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      messageBody: json['message_body'],
      sender: json['sender'],
      chatroomId: json['chatroom_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to convert a Message object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message_body': messageBody,
      'sender': sender,
      'chatroom_id': chatroomId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
