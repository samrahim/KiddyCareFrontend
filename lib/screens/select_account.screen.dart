import 'package:babysitter/screens/parent_screens/parent_register.dart';
import 'package:babysitter/screens/sitter_screens.dart/siter_register.dart';
import 'package:babysitter/widgets/selectcontainer.dart';
import 'package:flutter/material.dart';

class SelectAccountScreen extends StatefulWidget {
  const SelectAccountScreen({super.key});

  @override
  State<SelectAccountScreen> createState() => _SelectAccountScreen();
}

class _SelectAccountScreen extends State<SelectAccountScreen> {
  bool parentselected = true;
  bool siterselected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                const FittedBox(
                    child: Text("Select User type",
                        style: TextStyle(fontSize: 30))),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.purple.shade300),
                  height: 8,
                  width: MediaQuery.of(context).size.width / 4,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          parentselected = true;
                          siterselected = false;
                        });
                      },
                      child: FittedBox(
                        child: SelectContainer(
                            isSelected: parentselected,
                            imagePath:
                                "mom-icon-in-cartoon-style-vector-8655229.jpg",
                            parent: "Parent"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          parentselected = false;
                          siterselected = true;
                        });
                      },
                      child: SelectContainer(
                          isSelected: siterselected,
                          imagePath: "download.png",
                          parent: "Sitter"),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 7),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade300),
                    onPressed: () {
                      if (parentselected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ParentRegister()));
                      } else if (siterselected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SiterRegister()));
                      }
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
