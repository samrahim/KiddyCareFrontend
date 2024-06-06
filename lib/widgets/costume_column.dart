import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  final double containerWidth;

  final double middleContainerWidth;

  const CustomColumn(
      {super.key,
      required this.containerWidth,
      required this.middleContainerWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Container(color: Colors.black.withOpacity(0.65))),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          child: Row(
            children: [
              Container(
                width: containerWidth,
                color: Colors.black.withOpacity(0.65),
              ),
              Container(
                width: middleContainerWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 4,
                  ),
                ),
              ),
              Container(
                width: containerWidth,
                color: Colors.black.withOpacity(0.65),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(color: Colors.black.withOpacity(0.65))),
        ),
      ],
    );
  }
}
