import 'dart:convert';

import 'package:babysitter/consts.dart';
import 'package:babysitter/models/job_model.dart';
import 'package:babysitter/screens/parent_screens/parent_add_job_details.dart';
import 'package:babysitter/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ParentAddScreen extends StatefulWidget {
  final int parentId;

  const ParentAddScreen({super.key, required this.parentId});

  @override
  State<ParentAddScreen> createState() => _ParentAddScreenState();
}

class _ParentAddScreenState extends State<ParentAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Job posts"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddJob(parentId: widget.parentId),
                  ),
                );
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width - 20,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(20),
                  dashPattern: const [10, 10],
                  color: const Color.fromARGB(255, 240, 83, 180),
                  strokeWidth: 3,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_box_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 240, 83, 180),
                        ),
                        Text(
                          "Post a Job",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: FutureBuilder(
                    future: getJobg(parentId: widget.parentId),
                    builder: (context, snap) {
                      return ListView.builder(
                        itemCount: snap.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          DateTime date = snap.data![index].date!;
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          return snap.hasData
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircAvatar(
                                                      imagePath: snap
                                                          .data![index]
                                                          .familleImagePath!),
                                                  const SizedBox(width: 10),
                                                  Text(snap.data![index]
                                                      .familleName!)
                                                ],
                                              ),
                                              const Icon(Icons.more_vert)
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                snap.data![index].descreption!),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.next_plan,
                                                        color: Colors
                                                            .purple.shade300,
                                                      ),
                                                      Column(
                                                        children: [
                                                          const Text(
                                                              "Required on"),
                                                          Text(formattedDate),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors
                                                            .purple.shade300,
                                                      ),
                                                      const Column(
                                                        children: [
                                                          Text("City"),
                                                          Text("Batna"),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.child_care,
                                                        color: Colors
                                                            .purple.shade300,
                                                      ),
                                                      Column(
                                                        children: [
                                                          const Text(
                                                              "Childred"),
                                                          Text(
                                                              "${snap.data![index].children} children"),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors
                                                            .purple.shade300,
                                                      ),
                                                      Column(
                                                        children: [
                                                          const Text(
                                                              "Prefred hourly cost"),
                                                          Text(
                                                              "${snap.data![index].minPriceForHoure}-${snap.data![index].maxPriceForHoure} DZD"),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                        },
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<JobModel>> getJobg({required int parentId}) async {
  List<JobModel> jobs;
  final response = await http.get(Uri.parse("$baseUrl/jobs/getjobs/$parentId"));
  List data = json.decode(response.body);
  jobs = data.map((e) => JobModel.fromJson(e)).toList();

  return jobs;
}
