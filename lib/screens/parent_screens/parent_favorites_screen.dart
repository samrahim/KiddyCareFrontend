import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/models/sitter.model.dart';
import 'package:babysitter/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParentFavoritesScreen extends StatefulWidget {
  final int parentId;
  const ParentFavoritesScreen({super.key, required this.parentId});

  @override
  State<ParentFavoritesScreen> createState() => _ParentFavoritesScreenState();
}

class _ParentFavoritesScreenState extends State<ParentFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getFavorites(parentId: widget.parentId),
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snap.data!.length,
                  itemBuilder: (context, ind) {
                    return Card(
                      margin: const EdgeInsets.all(6),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircAvatar(
                                    imagePath:
                                        snap.data![ind].sitterImagePath!),
                                const SizedBox(width: 24),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snap.data![ind].sitterName),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        Text(snap.data![ind].averageRating
                                            .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () async {
                                  final val = await delete(
                                      parentId: widget.parentId,
                                      sitterId: snap.data![ind].sitterId!);
                                  if (val == 200) {
                                    setState(() {
                                      getFavorites(parentId: widget.parentId);
                                    });
                                  } else {
                                    null;
                                  }
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}

Future<int> delete({required int parentId, required int sitterId}) async {
  final response = await http
      .delete(Uri.parse("$baseUrl/famille/delete/$parentId/$sitterId"));

  return response.statusCode;
}

Future<List<SitterModel>> getFavorites({required parentId}) async {
  List<SitterModel> sitters;

  final response =
      await http.get(Uri.parse("$baseUrl/famille/myfavorites/$parentId"));
  print(response.body);
  List body = json.decode(response.body);
  sitters = body.map((e) => SitterModel.fromJson(e)).toList();
  print(sitters);
  return sitters;
}
