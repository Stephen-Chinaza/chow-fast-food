import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final String bgEffect;
  final double height;
  const SummaryCard(
      {required this.child,
      required this.bgEffect,
      required this.color,
      this.height = 150,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: color,
            image: DecorationImage(
                image: AssetImage(bgEffect),
                fit: BoxFit.fill,
                alignment: Alignment.center,
                opacity: 0.1),
            borderRadius: BorderRadius.circular(10.0)),
        child: child);
  }
}
