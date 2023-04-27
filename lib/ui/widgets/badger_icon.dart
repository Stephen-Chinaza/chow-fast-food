import 'package:chow/res/app_colors.dart';
import 'package:flutter/material.dart';

class BadgerIcon extends StatelessWidget {
  final Widget icon;
  final int count;
  final VoidCallback? onPressed;
  const BadgerIcon(
      {required this.icon, this.onPressed, this.count = 0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, right: 2.0),
                child: icon,
              ),
              Visibility(
                  visible: count > 0,
                  child: Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColors.red,
                        child: Text(count > 9 ? '+9' : '$count',
                            style: const TextStyle(
                                fontSize: 5,
                                fontWeight: FontWeight.w400,
                                color: Colors.white))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
