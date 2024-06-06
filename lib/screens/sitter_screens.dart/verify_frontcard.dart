import 'dart:io';

import 'package:babysitter/blocs/imagespaths/images_path_bloc.dart';
import 'package:babysitter/consts.dart';
import 'package:babysitter/screens/sitter_screens.dart/pick_backid.dart';
import 'package:babysitter/screens/sitter_screens.dart/pick_fronid.dart';
import 'package:babysitter/widgets/inkverification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationFrontIdCard extends StatefulWidget {
  final String cardIdPath;
  const VerificationFrontIdCard({super.key, required this.cardIdPath});

  @override
  State<VerificationFrontIdCard> createState() => _VerificationIdCardState();
}

class _VerificationIdCardState extends State<VerificationFrontIdCard> {
  @override
  Widget build(BuildContext context) {
    final scal = MediaQuery.of(context).size.width / 360;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Your front ID Card",
                  style: titleTextStyle(scal, Colors.black),
                ),
                SizedBox(
                    height: height / 2,
                    width: width - 20,
                    child: Image.file(
                      File(widget.cardIdPath),
                      fit: BoxFit.cover,
                    )),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkVerification(
                          widht: width / 5,
                          function: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PickFrontIdCardImage()));
                          },
                          isContinue: false,
                          title: "TRY AGAIN"),
                      SizedBox(
                        width: width * 0.1,
                      ),
                      InkVerification(
                          widht: height / 5,
                          title: "CONTINUE",
                          isContinue: true,
                          function: () {
                            BlocProvider.of<ImagesPathBloc>(context).add(
                                SaveFronIdCardPath(
                                    frontIdPath: widget.cardIdPath));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PickBackImageIdCard()));
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
