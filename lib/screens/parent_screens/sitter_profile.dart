import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/models/sitter.model.dart';
import 'package:babysitter/screens/parent_screens/detail_chat_screen.dart';
import 'package:babysitter/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class SitterProfile extends StatefulWidget {
  final SitterModel sitter;
  final int parentId;
  const SitterProfile(
      {required this.parentId, super.key, required this.sitter});

  @override
  State<SitterProfile> createState() => _SitterProfileState();
}

class _SitterProfileState extends State<SitterProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromARGB(255, 244, 86, 233),
          title: const Text("Profile", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Center(
            child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.5,
                    ),
                    Text(
                      widget.sitter.sitterName,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 244, 86, 233),
                          fontSize: 28,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.sitter.sitterExperiance!,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(
                      widget.sitter.sitterBio!,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade600),
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () async {
                                final response = await addFavorite(
                                    parentId: widget.parentId,
                                    sitterId: widget.sitter.sitterId!);
                                if (response == 200 && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: Text(
                                              "Sitter Saved in favorites")));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 244, 86, 233),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                height: 40,
                                child: const Center(
                                  child: Text(
                                    "Add in favorites",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ParentDetailsChatScreen(
                                              imagePath: widget
                                                  .sitter.sitterImagePath!,
                                              sitterName:
                                                  widget.sitter.sitterName,
                                              parentId: widget.parentId,
                                              sitterId: widget.sitter.sitterId!,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 244, 86, 233),
                                      width: 2),
                                ),
                                height: 40,
                                child: const Center(
                                  child: Text("Message"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder(
                            future: getSitterRating(
                                sitterId: widget.sitter.sitterId!),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                return ListView.builder(
                                    itemCount: snap.data!.length,
                                    itemBuilder: (context, ind) {
                                      return Card(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircAvatar(
                                                      imagePath: snap.data![ind]
                                                          .familleImagePath!),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(snap.data![ind]
                                                              .familleName!),
                                                          RatingBar.builder(
                                                            itemSize: 20,
                                                            initialRating: snap
                                                                .data![ind]
                                                                .rating!,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (newval) {},
                                                            ignoreGestures:
                                                                true,
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        snap.data![ind]
                                                            .ratingComment!,
                                                        maxLines: 3,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              } else if (snap.hasError) {
                                return Text(snap.error.toString());
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 244, 86, 233),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(200, 70),
                  )),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 7,
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        widget.sitter.sitterImagePath!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}

Future<int> addFavorite({required int parentId, required int sitterId}) async {
  final response = await http
      .post(Uri.parse('$baseUrl/famille/addfavorites/$parentId/$sitterId'));
  return response.statusCode;
}

Future<List<Rating>> getSitterRating({required int sitterId}) async {
  List<Rating> ratings;
  final response =
      await http.get(Uri.parse('$baseUrl/famille/sitterrating/$sitterId'));

  List data = json.decode(response.body);
  ratings = data.map((e) => Rating.fromJson(e)).toList();
  return ratings;
}

class Rating {
  double? rating;
  String? ratingComment;
  // String? createdAt;
  String? familleName;
  String? familleImagePath;

  Rating(
      {this.rating,
      this.ratingComment,
      // this.createdAt,
      this.familleName,
      this.familleImagePath});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rating: json['rating'] + 0.0,
      ratingComment: json['ratingComment'],
      // createdAt: json['createdAt'],
      familleImagePath: json['Famille']['familleImagePath'],
      familleName: json['Famille']['familleName'],
    );
  }
}
