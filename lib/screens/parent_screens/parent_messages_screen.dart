// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/screens/parent_screens/detail_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParentMessagesScreen extends StatefulWidget {
  const ParentMessagesScreen({super.key});

  @override
  State<ParentMessagesScreen> createState() => _ParentMessagesScreenState();
}

class _ParentMessagesScreenState extends State<ParentMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text("chats screen"),
        FutureBuilder(
            future: getChats(8),
            builder: (context, snap) {
              if (snap.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snap.data!.length,
                    itemBuilder: (context, ind) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ParentDetailsChatScreen(
                                            chatId:
                                                snap.data![ind].chatroomId)));
                          },
                          leading: Image.asset(
                              "images/mom-icon-in-cartoon-style-vector-8655229.jpg"),
                          title: Text(snap.data![ind].sitterName),
                        ),
                      );
                    },
                  ),
                );
              } else if (snap.hasError) {
                return Center(
                  child: Text(snap.error!.toString()),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ],
    ));
  }
}

class ParentChats {
  int chatroomId;
  int familleId;
  int sitterId;
  String createdAt;
  String updatedAt;
  // Sitter? sitter;
  String sitterName;
  String sitterImagePath;
  int sitterIds;

  ParentChats(
      // this.sitter,
      {
    required this.chatroomId,
    required this.familleId,
    required this.sitterId,
    required this.createdAt,
    required this.updatedAt,
    required this.sitterName,
    required this.sitterImagePath,
    required this.sitterIds,
  });

  factory ParentChats.fromJson(Map<String, dynamic> json) {
    return ParentChats(
      chatroomId: json['chatroom_id'],
      familleId: json['famille_id'],
      sitterId: json['sitter_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      sitterName: json['Sitter']["sitterName"],
      sitterIds: json['Sitter']["id"],
      sitterImagePath: json["Sitter"]["sitterImagePath"],
    );
  }
}

Future<List<ParentChats>> getChats(int id) async {
  // int id = await SharedPreferences.getInstance().then((value) {
  //   print('${value.getInt("id")} int');
  //   return value.getInt("id")!;
  // });

  final res = await http.get(Uri.parse("$baseUrl/famille/chats/$id"));

  List map = json.decode(res.body);
  List<ParentChats> chats = map.map((e) => ParentChats.fromJson(e)).toList();

  return chats;
}

// class Sitter {
//   int? id;
//   String? sitterName;
//   String? sitterImagePath;
//   String? createdAt;
//   String? updatedAt;

//   Sitter(
//       {this.id,
//       this.sitterName,
//       this.sitterImagePath,
//       this.createdAt,
//       this.updatedAt});

//   Sitter.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     sitterName = json['sitterName'];
//     sitterImagePath = json['sitterImagePath'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['sitterName'] = sitterName;
//     data['sitterImagePath'] = sitterImagePath;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     return data;
//   }
//}