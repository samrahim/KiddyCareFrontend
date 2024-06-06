import 'dart:convert';

import 'package:babysitter/blocs/sitterinfo/sitter_info_bloc.dart';
import 'package:babysitter/consts.dart';
import 'package:babysitter/models/job_model.dart';
import 'package:babysitter/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SitterJobsScreen extends StatefulWidget {
  const SitterJobsScreen({super.key});

  @override
  State<SitterJobsScreen> createState() => _SitterJobsScreenState();
}

class _SitterJobsScreenState extends State<SitterJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<SitterInfoBloc, SitterInfoState>(
            builder: (context, state) {
              if (state is SitterinfoLoaded) {
                return Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            FittedBox(
                                child: CircAvatar(
                                    imagePath: state.model.sitterImagePath!)),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'hi ,${state.model.sitterName}',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.purple.shade300,
                              size: 25,
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Welcome to ",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade500),
                              ),
                              const Text('KiddyCare',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 3, 58, 155)))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Let's find the best job for you",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: FutureBuilder(
                            future: getEmptyJobs(),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                return ListView.builder(
                                    itemCount: snap.data!.length,
                                    itemBuilder: (context, ind) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CircAvatar(
                                                        imagePath: snap
                                                            .data![ind]
                                                            .familleImagePath!),
                                                    const SizedBox(width: 8),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snap.data![ind]
                                                              .familleName!,
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Colors.grey
                                                                  .shade600),
                                                        ),
                                                        Text(timedifference(
                                                                createdAt: snap
                                                                    .data![ind]
                                                                    .createdAt!)
                                                            .toString())
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  snap.data![ind].descreption!,
                                                  maxLines: 3,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .purple
                                                                  .shade300,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: const Icon(
                                                            Icons
                                                                .navigate_next_rounded,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Column(
                                                          children: [
                                                            const Text(
                                                                "Required on"),
                                                            Text(
                                                              timedifference(
                                                                  createdAt: snap
                                                                      .data![
                                                                          ind]
                                                                      .date!),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .purple
                                                                  .shade300,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: const Icon(
                                                            Icons.location_on,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Column(
                                                          children: [
                                                            const Text("City"),
                                                            Text(
                                                              "Batna",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.child_care,
                                                          size: 32,
                                                          color: Colors
                                                              .purple.shade300,
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Column(
                                                          children: [
                                                            const Text(
                                                                "children"),
                                                            Text(
                                                              '${snap.data![ind].children} Kids',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.money_rounded,
                                                          color: Colors
                                                              .purple.shade300,
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text("Cost"),
                                                            Text(
                                                              '${snap.data![ind].maxPriceForHoure} - ${snap.data![ind].maxPriceForHoure} DZD /h',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.purple
                                                                  .shade300),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Apply for this job",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                    onPressed: () {},
                                                    child: const Text(
                                                      "View Details",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationStyle:
                                                              TextDecorationStyle
                                                                  .double,
                                                          decorationColor:
                                                              Colors.green,
                                                          color: Colors.green),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              } else if (snap.hasError) {
                                return Text(snap.error.toString());
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }))
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<JobModel>> getEmptyJobs() async {
  List<JobModel> jobs = [];
  final response = await http.get(Uri.parse("$baseUrl/jobs/getemptyjobs"));
  List data = json.decode(response.body);
  jobs = data.map((e) => JobModel.fromJson(e)).toList();
  return jobs;
}

String timedifference({required DateTime createdAt}) {
  Duration difference = DateTime.now().difference(createdAt);
  if (difference.inHours < 24) {
    return '${difference.inHours} hour ago';
  } else if (difference.inHours > 24) {
    return '${difference.inDays} day ago';
  } else {
    return '';
  }
}
