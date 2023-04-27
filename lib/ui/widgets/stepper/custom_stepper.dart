
import 'package:flutter/material.dart';

import '../../../utils/app_utils.dart';
import 'custom_step.dart';

class CustomStepper extends StatefulWidget {
  final List<CustomStep> steps;
  final int dotCount;
  final int currentStep;
  final double elevation;
  final double contentPadding;
  final double height;
  const CustomStepper({
    required this.steps,
    this.dotCount=20,
    required this.currentStep,
    this.elevation=5,
    this.contentPadding=15.0,
    this.height=100,
    Key? key}) : super(key: key);

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context)=>Column(
    children: [
      SizedBox(
        height: widget.height,
        child: Card(
            elevation: widget.elevation,
            margin: EdgeInsets.zero,
            child: Center(
              child: ListView.builder(
                itemCount: widget.steps.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.all(15.0),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final step=widget.steps[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(step.title!=null)...[
                        Text(step.title!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                        const SizedBox(height: 8.0)
                      ],
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            step,
                            _buildLine(!_isLast(index),
                                completed: _isCompleted(index))
                          ]
                      ),
                      if(step.subtitle!=null)...[
                        const SizedBox(height: 8.0),
                        if(_isCompleted(index))...[
                          Text(step.subtitle!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12))
                        ]else...[
                          const SizedBox(height: 15)
                        ]
                      ]
                    ],
                  );
                },
              ),
            )),
      ),
      if(widget.steps[widget.currentStep].content!=null)...[
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(width: AppUtils.deviceScreenSize(context).width,
                child: Column(
                  children: [
                    SizedBox(height: widget.contentPadding),
                    widget.steps[widget.currentStep].content!,
                  ],
                )),
          ),
        )
      ]
    ],
  );

  Widget _buildLine(bool visible,
      {required bool completed}) {
    if(visible) {

      final height=completed ? 2.0 : 1.0;
      final padding=completed ? 0.0 : 2.0;
      final width=completed ? 6.0 : 2.0;
      final color=completed ? Theme.of(context).colorScheme.secondary : Theme.of(context).dividerColor;

      return Row(children: List.generate(widget.dotCount,
              (index) => Container(width: width,
              color: color,
              height: height,
              margin: EdgeInsets.symmetric(horizontal: padding))));
    }
    return const SizedBox.shrink();
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCompleted(int index) {
    return index<widget.currentStep;
  }

}