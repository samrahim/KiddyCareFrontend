import 'dart:convert';

import 'package:babysitter/blocs/parentinfo/parentnfo_bloc.dart';
import 'package:babysitter/consts.dart';
import 'package:babysitter/models/sitter.model.dart';
import 'package:babysitter/widgets/custom_avatar.dart';
import 'package:babysitter/widgets/custom_card.dart';
import 'package:babysitter/widgets/custom_row_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  Icon notyetfavorite = const Icon(
    Icons.favorite_border,
    color: Colors.red,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: SingleChildScrollView(
        child: BlocBuilder<ParentnfoBloc, ParentnfoState>(
            builder: (context, state) {
          if (state is ParentinfoLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FittedBox(
                                child: CircAvatar(
                                    imagePath: state.model.familleImagePath)),
                            const SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'hi ,${state.model.familleName}',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(state.model.familleAdress)
                              ],
                            )
                          ],
                        ),
                        Icon(
                          Icons.notifications,
                          color: Colors.purple.shade300,
                          size: 25,
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.purple.shade300,
                          ),
                          hintText: "Search",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.purple.shade300, width: 1.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.purple.shade300, width: 2))),
                    ),
                    const CustomTitleRow(title: "Babysitters nearby"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: FutureBuilder(
                          future: getBynearbySitters(
                              long: state.model.familleLongitude.toString(),
                              lat: state.model.familleLatitude.toString()),
                          builder: (context, snap) {
                            if (snap.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snap.data!.length,
                                itemBuilder: (context, ind) {
                                  final sitter = snap.data![ind];
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: CustomCard(
                                        sitter: sitter, model: state.model),
                                  );
                                },
                              );
                            } else {
                              return SizedBox(
                                child: Text(snap.error.toString()),
                              );
                            }
                          }),
                    ),
                    const CustomTitleRow(title: 'New babysitters'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: FutureBuilder(
                          future: getNewSitters(),
                          builder: (context, snap) {
                            if (snap.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snap.data!.length,
                                itemBuilder: (context, ind) {
                                  final sitter = snap.data![ind];
                                  return snap.hasData
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CustomCard(
                                              sitter: sitter,
                                              model: state.model),
                                        )
                                      : const SizedBox();
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ),
                    const CustomTitleRow(title: 'Top rated'),
                    SizedBox(
                      child: FutureBuilder(
                          future: topRated(),
                          builder: (context, snap) {
                            print(snap.data);
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircAvatar(
                                                    imagePath: snap.data![ind]
                                                        .sitterImagePath!),
                                                const SizedBox(width: 24),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snap
                                                        .data![ind].sitterName),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                        Text(snap.data![ind]
                                                            .averageRating
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  final response =
                                                      await addFavorite(
                                                          parentId: state
                                                              .model.familleId!,
                                                          sitterId: snap
                                                              .data![ind]
                                                              .sitterId!);

                                                  if (response == 201 &&
                                                      context.mounted) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            2),
                                                                content: Text(
                                                                    "this sitter was saved in favorites")));
                                                  }
                                                },
                                                icon: notyetfavorite)
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return const SizedBox();
                            }
                          }),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      )),
    );
  }
}

Future<int> addFavorite({required int parentId, required int sitterId}) async {
  final response = await http
      .post(Uri.parse('$baseUrl/famille/addfavorites/$parentId/$sitterId'));
  return response.statusCode;
}

Future<List<SitterModel>> getBynearbySitters(
    {required String long, required String lat}) async {
  List<SitterModel> sitters;
  final response = await http
      .get(Uri.parse("$baseUrl/famille/findsittersnearby/$lat/$long"));
  List body = json.decode(response.body);

  sitters = body.map((e) => SitterModel.fromJson(e)).toList();

  return sitters;
}

Future<List<SitterModel>> getNewSitters() async {
  List<SitterModel> sitters;
  final response = await http.get(Uri.parse("$baseUrl/famille/getnewsitters"));
  List body = json.decode(response.body);

  sitters = body.map((e) => SitterModel.fromJson(e)).toList();

  return sitters;
}

Future<List<SitterModel>> topRated() async {
  List<SitterModel> sitters;
  final response = await http.get(Uri.parse("$baseUrl/famille/toprated"));
  List body = json.decode(response.body);
  sitters = body.map((e) => SitterModel.fromJson(e)).toList();
  return sitters;
}
