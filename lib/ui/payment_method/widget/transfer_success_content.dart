import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';

class TransferSuccess extends StatelessWidget {
  final String title;
  final String description1;
  final String? description2;
  final String amount;
  final String? phone;

  const TransferSuccess(
      {Key? key,
      required this.title,
      required this.description1,
      this.description2,
      required this.amount,
      this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 35),
      children: [
        Center(
          child: CustomText(
            weight: FontWeight.w700,
            size: 32,
            maxLines: 2,
            text: title,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Center(
          child: CustomText(
            weight: FontWeight.w400,
            size: 18,
            maxLines: 2,
            text: description1,
            color: Theme.of(context).textTheme.caption!.color,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: Text.rich(TextSpan(children: [
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, 0),
                child: Text('NGN',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.caption!.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 21.81)),
              ),
            ),
            TextSpan(
                text: amount,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 28.05))
          ])),
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: CustomText(
            weight: FontWeight.w400,
            size: 18,
            maxLines: 2,
            text: description2,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: CustomText(
            weight: FontWeight.w600,
            size: 24,
            maxLines: 2,
            text: phone,
            color: Theme.of(context).textTheme.caption!.color,
          ),
        ),
      ],
    );
  }
}
