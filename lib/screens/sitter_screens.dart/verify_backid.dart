import 'dart:io';

import 'package:babysitter/blocs/imagespaths/images_path_bloc.dart';
import 'package:babysitter/blocs/sitterauthbloc/sitterauthbloc_bloc.dart';
import 'package:babysitter/consts.dart';
import 'package:babysitter/screens/sitter_screens.dart/finalscreen.dart';
import 'package:babysitter/screens/sitter_screens.dart/pick_backid.dart';
import 'package:babysitter/widgets/inkverification.dart';
import 'package:babysitter/widgets/loadingwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationBackIdCard extends StatefulWidget {
  final String backcardIdPath;

  const VerificationBackIdCard(
      {super.key, required this.backcardIdPath});

  @override
  State<VerificationBackIdCard> createState() => _VerificationIdCardState();
}

class _VerificationIdCardState extends State<VerificationBackIdCard> {
  @override
  Widget build(BuildContext context) {
    final scal = MediaQuery.of(context).size.width / 360;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: BlocConsumer<SitterauthblocBloc, SitterauthblocState>(
                builder: (context, state) {
      if (state is SendCardIdLoading) {
        return const Center(child: LoadingWidget());
      } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Your back ID Card",
                  style: titleTextStyle(scal, Colors.black),
                ),
                SizedBox(
                    height: height / 2,
                    width: width - 20,
                    child: Image.file(
                      File(widget.backcardIdPath),
                      fit: BoxFit.cover,
                    )),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkVerification(
                          widht: width / 5,
                          function: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PickBackImageIdCard()));
                          },
                          isContinue: false,
                          title: "TRY AGAIN"),
                      SizedBox(
                        width: width * 0.1,
                      ),
                      InkVerification(
                        widht: width / 5,
                        title: "CONTINUE",
                        isContinue: true,
                        function: () {
                          context.read<ImagesPathBloc>().add(SaveBackIdCard(
                              backIdPath: widget.backcardIdPath));
                          BlocProvider.of<SitterauthblocBloc>(context).add(
                              SendFrontAndBackIdCardsEvent(
                                 ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }, listener: (context, state) {
      if (state is SendCardIdSuccess) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FinalScreen()));
      }
    })));
  }
}
