import 'dart:convert';
import 'package:babysitter/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddJob extends StatefulWidget {
  final int parentId;
  const AddJob({super.key, required this.parentId});

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  TextEditingController jobDesc = TextEditingController();
  DateTime dateTime = DateTime.now();
  int _selectedChildNumber = 1;
  String starttime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = "9:30 PM";
  RangeValues selectedRange = const RangeValues(500, 5000);
  @override
  Widget build(BuildContext context) {
    print(widget.parentId);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Write a job",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: jobDesc,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "What do you want",
                      hintStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.purple.shade300, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.pink, width: 2),
                      )),
                ),
                const Text(
                  "Children to take care about",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple.shade300, width: 2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButtonFormField(
                    icon: Icon(
                      Icons.child_care,
                      color: Colors.purple.shade300,
                    ),
                    value: _selectedChildNumber,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedChildNumber = newValue!;
                      });
                    },
                    items: List.generate(10, (index) => index + 1)
                        .map((number) => DropdownMenuItem(
                              value: number,
                              child: Text('$number'),
                            ))
                        .toList(),
                  ),
                ),
                const Text(
                  "Date",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          getDateTime();
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.purple.shade300,
                        )),
                    hintText: DateFormat('dd/MM/yyyy').format(dateTime),
                    hintStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple.shade300, width: 2)),
                  ),
                  readOnly: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Start time",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            child: TextField(
                              onTap: () {
                                getTimeFromUser(isStartTime: true);
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                    color: Colors.purple.shade300,
                                    Icons.access_time_rounded),
                                hintText: starttime,
                                hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple.shade300,
                                        width: 2)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "End time",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            child: TextField(
                              onTap: () {
                                getTimeFromUser(isStartTime: false);
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                    color: Colors.purple.shade300,
                                    Icons.access_time_rounded),
                                hintText: endTime,
                                hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple.shade300,
                                        width: 2)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Select your prefered hour rate",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                RangeSlider(
                  values: selectedRange,
                  onChanged: (RangeValues values) {
                    setState(() {
                      selectedRange = values;
                    });
                  },
                  min: 500,
                  max: 5000,
                  divisions: 45,
                  activeColor: Colors.purple.shade300,
                  labels: RangeLabels(
                      '${selectedRange.start.round().toString()} DA',
                      '${selectedRange.end.round().toString()} DA '),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.purple.shade300,
                          textStyle: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.w700)),
                      onPressed: () async {
                        Response response = await http.post(
                            Uri.parse(
                                "$baseUrl/jobs/create/${widget.parentId}"),
                            body: json.encode({
                              "descreption": jobDesc.text,
                              "parent_Id": widget.parentId,
                              "children": _selectedChildNumber,
                              "date": dateTime.toIso8601String(),
                              "startTime": starttime,
                              "endTime": endTime,
                              "minPriceForHoure": selectedRange.start + 0.0,
                              "maxPriceForHoure": selectedRange.end + 0.0,
                            }),
                            encoding: Encoding.getByName('utf-8'),
                            headers: {'Content-Type': 'application/json'});
                        if (response.statusCode == 200 && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text("job created successfully")));
                          Navigator.pop(context);
                        } else if (response.statusCode != 200 &&
                            context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text(
                                  "Something went to wrong please try again")));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Add job")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDateTime() async {
    DateTime? time = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2222));
    if (time != null) {
      setState(() {
        dateTime = time;
      });
    } else {
      return DateTime.now();
    }
  }

  getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimepick();

    if (pickedTime == null) {
    } else if (isStartTime == true && context.mounted) {
      String formatedTime = pickedTime.format(context);
      setState(() {
        starttime = formatedTime;
      });
    } else if (isStartTime == false && context.mounted) {
      String formatedTime = pickedTime.format(context);
      setState(() {
        endTime = formatedTime;
      });
    }
  }

  Future<TimeOfDay?> showTimepick() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(starttime.split(":")[0]),
        minute: int.parse(starttime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
