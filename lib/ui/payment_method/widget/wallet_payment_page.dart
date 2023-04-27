import 'package:chow/model/view_models/user_view_model.dart';
import 'package:chow/res/enum.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../modals.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import 'fund_wallet_overlay.dart';
import '../../widgets/image_view.dart';

class WalletDetailsPage extends StatelessWidget {
  final String amount;
  const WalletDetailsPage({required this.amount,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletBalance = Provider.of<UserViewModel>(context, listen: false).walletBalance;
    final valid=walletBalance>=double.parse(amount);
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).primaryColor,
            ),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 19),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 33,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        size: 14,
                        text: 'Total Amount:',
                        color: Theme.of(context).textTheme.caption!.color,
                        weight: FontWeight.w500,
                      ),
                      Text.rich(TextSpan(children: [
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0, 0),
                            child: Text('NGN ',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                          ),
                        ),
                        TextSpan(
                            text: AppUtils.convertPrice(amount),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 18))
                      ])),
                    ],
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        size: 14,
                        text: 'Wallet Balance:',
                        color: Theme.of(context).textTheme.caption!.color,
                        weight: FontWeight.w500,
                      ),
                      Text.rich(TextSpan(children: [
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0, 0),
                            child: Text('NGN ',
                                style: TextStyle(
                                    color: valid ? Theme.of(context).colorScheme.secondary
                                        : AppColors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                          ),
                        ),
                        TextSpan(
                            text: AppUtils.convertPrice(walletBalance),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: valid ? Theme.of(context).colorScheme.secondary
                                    : AppColors.red,
                                fontSize: 18))
                      ])),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 24,
                  ),
                  if(!valid)...[
                    Row(children: [
                      const Expanded(
                        flex: 1,
                        child: ImageView.svg(AppImages.icWarning),
                      ),
                      const Spacer(),
                      Expanded(
                          flex: 8,
                          child: Text(
                              'Insufficient Balance. Please top-up your wallet or try another payment method',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color:
                                  Theme.of(context).textTheme.caption!.color,
                                  fontSize: 14))),
                    ]),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 66),
                        child: ButtonView(
                            onPressed: () => Modals.showBottomSheetModal(
                              context,
                              borderRadius: 25,
                              heightFactor: 0.9,
                              page: const FundWalletOverlay(
                                  btnText: 'Continue',
                                  subTitle: 'How much do you want to topup in your Chow wallet?',
                                  title: 'Top up'),
                              isScrollControlled: true,
                            ),
                            expanded: false,
                            borderColor: Theme.of(context).colorScheme.secondary,
                            color: Theme.of(context).primaryColor,
                            borderRadius: 6.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ImageView.svg(AppImages.icTopUp,
                                    color:
                                    Theme.of(context).colorScheme.secondary),
                                const SizedBox(width: 10),
                                Text('Top-up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 13)),
                              ],
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 29,
                    )
                  ]
                ],
              ),
            )),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ButtonView(
              disabled: !valid,
              onPressed: ()=> Navigator.pop(context, PaymentMethod.wallet),
              child: const Text('Pay',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18))),
        ),
        const SizedBox(
          height: 29,
        )
      ],
    );
  }
}
