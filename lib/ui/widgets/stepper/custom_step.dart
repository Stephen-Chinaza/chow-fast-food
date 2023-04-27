
import 'package:chow/res/app_images.dart';
import 'package:flutter/material.dart';

import '../../../res/enum.dart';
import '../image_view.dart';

class CustomStep extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? content;
  final CustomStepState state;
  const CustomStep({this.title,
    this.subtitle,
    this.content,
    required this.state,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageView.svg(state==CustomStepState.idle
        ? AppImages.icStepIdle: state==CustomStepState.current?
    AppImages.icStepCurrent : state==CustomStepState.completed
        ? AppImages.icStepCompleted : AppImages.icStepDisabled,
      height: 24, width: 24);
  }
}
