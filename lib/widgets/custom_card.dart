import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/models/famille.model.dart';
import 'package:babysitter/models/sitter.model.dart';
import 'package:babysitter/screens/parent_screens/detail_chat_screen.dart';
import 'package:babysitter/screens/parent_screens/sitter_profile.dart';
import 'package:babysitter/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class CustomCard extends StatefulWidget {
  final SitterModel sitter;
  final FamilleModel model;
  const CustomCard({super.key, required this.sitter, required this.model});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  TextEditingController commentCont = TextEditingController();
  double rating = 3;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: CircAvatar(
                    imagePath: widget.sitter.sitterImagePath!,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          widget.sitter.sitterName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.purple.shade300,
                          ),
                          SizedBox(
                            width: 65,
                            height: 30,
                            child: Center(
                              child: Text(
                                ' ${widget.sitter.sitterAddress!}',
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ce) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    FittedBox(
                                      child: Text(
                                        "Rate ${widget.sitter.sitterName}",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    FittedBox(
                                      child: RatingBar.builder(
                                        initialRating: rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.child_care,
                                          color: Color.fromARGB(
                                              255, 241, 117, 158),
                                        ),
                                        onRatingUpdate: (newrating) {
                                          setState(() {
                                            rating = newrating;
                                          });
                                        },
                                      ),
                                    ),
                                    const Text(
                                      "add comment",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    TextFormField(
                                      controller: commentCont,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 244, 86, 233),
                                                  width: 1.5)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 244, 86, 233),
                                                  width: 1.5))),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(ce);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await addRating(
                                                    parentId:
                                                        widget.model.familleId!,
                                                    sitterId:
                                                        widget.sitter.sitterId!,
                                                    rating: rating,
                                                    ratingcommnt:
                                                        commentCont.text)
                                                .then((value) {
                                              Navigator.pop(ce);
                                            });
                                          },
                                          child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 241, 117, 158),
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    Text(widget.sitter.averageRating.toString())
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.sitter.sitterBio == null
                  ? "Bio : this sitter bio \nis empty now"
                  : "Bio :${widget.sitter.sitterBio}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            Row(
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SitterProfile(
                                    parentId: widget.model.familleId!,
                                    sitter: widget.sitter,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 40,
                      child: const Center(
                        child: Text(
                          "view profile",
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
                              builder: (context) => ParentDetailsChatScreen(
                                    imagePath: widget.sitter.sitterImagePath!,
                                    sitterName: widget.sitter.sitterName,
                                    parentId: widget.model.familleId!,
                                    sitterId: widget.sitter.sitterId!,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.purple.shade300, width: 2),
                      ),
                      height: 40,
                      child: const Center(
                        child: Text("Message"),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> addRating(
    {required int parentId,
    required int sitterId,
    required double rating,
    required String? ratingcommnt}) async {
  await http.post(Uri.parse("$baseUrl/famille/rate/$parentId/$sitterId"),
      body: json.encode({'rating': rating, 'ratingComment': ratingcommnt}),
      headers: {'Content-Type': 'application/json'},
      encoding: Encoding.getByName('utf-8'));
}
