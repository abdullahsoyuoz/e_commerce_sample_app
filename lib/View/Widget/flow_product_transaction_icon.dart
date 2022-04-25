import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FlowProductTransactionIcon extends StatelessWidget {
  IconData icon;
  Color? color;
  Color? backgroundColor;
  FlowProductTransactionIcon({Key? key, required this.icon, this.color = Colors.white, this.backgroundColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: backgroundColor!),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
