import 'package:chow/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../widgets/button_view.dart';
import '../../widgets/image_view.dart';

class BankPaymentScreen extends StatelessWidget {
  const BankPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            color: Theme.of(context).primaryColor,
            child: Material(
              color: Theme.of(context).primaryColor,
              elevation: 5,
              child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 20),
                    CustomText(
                      text: 'Account Details',
                      size: 24,
                      weight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text:
                          'To fund your chow wallet, please transfer money directory  to the bank account below',
                      maxLines: 2,
                      size: 14,
                      weight: FontWeight.w500,
                      color: Theme.of(context).textTheme.caption!.color,
                    ),
                    const SizedBox(height: 47),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'ACCOUNT NUMBER',
                          size: 14,
                          weight: FontWeight.w600,
                          color: Theme.of(context).textTheme.caption!.color,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CustomText(
                              text: '9926374776',
                              size: 24,
                              weight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            const Spacer(),
                            ButtonView(
                                onPressed: () {},
                                expanded: false,
                                borderColor:
                                    Theme.of(context).colorScheme.secondary,
                                color: Theme.of(context).primaryColor,
                                borderRadius: 12.0,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 19.6),
                                    ImageView.svg(AppImages.icCopy,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    const SizedBox(width: 14.53),
                                    Text('Copy',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 12)),
                                    const SizedBox(width: 22.6),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 37.92,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ImageView.svg(AppImages.icBankLogo),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'BANK NAME',
                              size: 12,
                              weight: FontWeight.w600,
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              text: 'Guarantee Trust Bank',
                              size: 18,
                              weight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              text: 'ACCOUNT NAME',
                              size: 13,
                              weight: FontWeight.w600,
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              text: 'JOHN OKEKE',
                              size: 18,
                              weight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
            )),
        const SizedBox(
          height: 31,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ButtonView(
              onPressed: () {},
              child: const Text('I Have Made The Transfer',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18))),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
