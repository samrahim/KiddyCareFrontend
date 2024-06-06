import 'package:babysitter/consts.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please wait ",
              style: titleTextStyle(
                  MediaQuery.of(context).size.width / 360, Colors.black),
            ),
            LoadingAnimationWidget.waveDots(
              color: Colors.black,
              size: MediaQuery.of(context).size.width / 4,
            ),
          ],
        ),
      ),
    );
  }
}
