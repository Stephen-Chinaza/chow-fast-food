import 'package:flutter/material.dart';

import '../../res/enum.dart';

class OrderButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget? child;
  final double width;
  final double height;
  final double? fontSize;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final OrderButtonType type;
  const OrderButton.outline(
      {Key? key,
      required this.onPressed,
      this.child,
      this.fontSize = 16.0,
      this.height = 32.0,
      this.width = double.maxFinite,
      this.color,
      this.borderColor,
      this.borderWidth = 1,
      this.borderRadius = 12,
      this.type = OrderButtonType.outline})
      : super(key: key);
  const OrderButton.normal(
      {Key? key,
      required this.onPressed,
      this.child,
      this.fontSize = 16.0,
      this.height = 32.0,
      this.width = double.maxFinite,
      this.color,
      this.borderColor,
      this.borderWidth = 1,
      this.borderRadius = 12,
      this.type = OrderButtonType.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (type == OrderButtonType.outline)
        ? InkWell(
            onTap: onPressed,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: null,
                  border: Border.all(color: color!, width: 1)),
              child: child,
            ),
          )
        : GestureDetector(
            onTap: onPressed,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: color,
              ),
              child: child,
            ),
          );
  }
}
