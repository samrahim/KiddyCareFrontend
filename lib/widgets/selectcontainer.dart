import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectContainer extends StatefulWidget {
  bool isSelected;
  final String imagePath;
  final String parent;
  SelectContainer(
      {super.key,
      required this.imagePath,
      required this.parent,
      required this.isSelected});

  @override
  State<SelectContainer> createState() => _SelectContainerState();
}

class _SelectContainerState extends State<SelectContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: widget.isSelected ? Colors.pink.shade300 : Colors.white,
              width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 2.2,
      child: Column(
        children: [
          SizedBox(
            child: Image.asset(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2.2,
              "images/${widget.imagePath}",
            ),
          ),
          Text(
            widget.parent,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
