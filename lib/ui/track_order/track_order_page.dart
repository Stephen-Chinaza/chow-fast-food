import 'package:flutter/material.dart';

import '../../res/enum.dart';
import '../widgets/custom_text.dart';
import '../widgets/stepper/custom_step.dart';
import '../widgets/stepper/custom_stepper.dart';
import 'widget/order_details.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int _currentStep = 1;

  final _steps = <String>['Received', 'Dispatched', 'Delivered', 'Completed'];

  final _stepsSubtitle = <String>['9:15am', '9:15am', '9:15am', '9:15am'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: CustomText(
            size: 24,
            text: 'Track Order',
            color: Theme.of(context).textTheme.bodyText1!.color,
            weight: FontWeight.w700,
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: ListView(
        children: [
          const SizedBox(
            height: 13,
          ),
          CustomStepper(
              dotCount: 10,
              currentStep: _currentStep,
              steps: List.generate(
                  _steps.length,
                      (index) => CustomStep(
                      title: _steps[index],
                      subtitle: _stepsSubtitle[index],
                      state: _currentStep > index
                          ? CustomStepState.current
                          : _currentStep == index
                          ? CustomStepState.completed
                          : CustomStepState.idle))),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Status',
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        weight: FontWeight.w400,
                        size: 18,
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      CustomText(
                        text: 'Order received by vendor',
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        weight: FontWeight.w700,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
              height: 103,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const OrderDetails(),
        ],
      ),
    );
  }
}
