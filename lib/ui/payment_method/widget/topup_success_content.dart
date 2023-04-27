import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';

class TopUpSuccess extends StatelessWidget {
  const TopUpSuccess({Key? key}) : super(key: key);

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
            text: 'Success!',
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
            text: 'Your wallet has been topup with ',
            color: Theme.of(context).textTheme.caption!.color,
          ),
        ),
        const SizedBox(
          height: 20,
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
                text: '3000',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 28.05))
          ])),
        ),
        const Spacer(),
      ],
    );
  }
}
