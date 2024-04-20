import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/screens/sitter_screens.dart/sitter_detais_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SitterMessagesScreen extends StatefulWidget {
  const SitterMessagesScreen({super.key});

  @override
  State<SitterMessagesScreen> createState() => _SitterMessagesScreenState();
}

class _SitterMessagesScreenState extends State<SitterMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: info(),
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                itemCount: snap.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SitterDetailsChatScreen(
                                  chatId: snap.data![index].chatroomId!)));
                    },
                    title: Text(snap.data![index].familleName!),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}

Future<List<SitterChats>> info() async {
  final response = await http.get(Uri.parse("$baseUrl/sitter/chats/2"));

  List map = json.decode(response.body);
  List<SitterChats> chats = map.map((e) => SitterChats.fromJson(e)).toList();

  return chats;
}

class SitterChats {
  int? chatroomId;
  int? familleId;
  int? sitterId;
  String? createdAt;
  String? updatedAt;

  String? familleName;

  SitterChats({
    this.chatroomId,
    this.familleId,
    this.sitterId,
    this.createdAt,
    this.updatedAt,
    this.familleName,
  });

  SitterChats.fromJson(Map<String, dynamic> json) {
    chatroomId = json['chatroom_id'];
    familleId = json['famille_id'];
    sitterId = json['sitter_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    familleName = json['Famille']['familleName'];
  }
}
