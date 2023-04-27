import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../modals.dart';
import '../../widgets/button_view.dart';
import '../../payment_method/widget/fund_wallet_overlay.dart';
import '../../widgets/image_view.dart';
import 'summary_card.dart';

class BalanceCard extends StatefulWidget {
  final Color color;
  final String caption;
  final String bgEffect;
  final bool wallet;
  final bool isSelected;
  final double balance;
  final GestureTapCallback onEdgeTap;

  const BalanceCard.voucher(
      {required this.isSelected,
        required this.onEdgeTap, 
        required this.balance, Key? key})
      : color = AppColors.yellow,
        bgEffect = AppImages.bgBalanceCardLeft,
        caption = 'Voucher Balance',
        wallet = false,
        super(key: key);

  const BalanceCard.wallet(
      {required this.isSelected,
        required this.onEdgeTap, 
        required this.balance, Key? key})
      : color = AppColors.lightSecondaryAccent,
        bgEffect = AppImages.bgBalanceCardRight,
        caption = 'Wallet Balance',
        wallet = true,
        super(key: key);

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!widget.isSelected) ...[
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: widget.onEdgeTap,
              child: CircleAvatar(radius: 10, backgroundColor: widget.color),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: widget.onEdgeTap,
              child: CircleAvatar(radius: 10, backgroundColor: widget.color),
            ),
          )
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SummaryCard(
              bgEffect: widget.bgEffect,
              color: widget.color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.caption,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Theme.of(context).canvasColor),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () => setState(() => _visible = !_visible),
                        child: ImageView.svg(
                            _visible
                                ? AppImages.icInvisible
                                : AppImages.icVisible,
                            color: Theme.of(context).canvasColor),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'NGN ${_visible ? AppUtils.convertPrice(widget.balance) : 'X' * 6}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Theme.of(context).canvasColor),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.wallet) ...[
                        ButtonView(
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
                            color: Theme.of(context).canvasColor,
                            borderRadius: 6.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ImageView.svg(AppImages.icTopUp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                        const SizedBox(width: 35.0),
                        ButtonView(
                            onPressed: () => Modals.showBottomSheetModal(
                                  context,
                                  borderRadius: 25,
                                  heightFactor: 0.9,
                                  page: const FundWalletOverlay(
                                      btnText: 'Transfer',
                                      subTitle: 'How much do you want to transfer to your friend?',
                                      title: 'Transfer '),
                                  isScrollControlled: true,
                                ),
                            expanded: false,
                            color: Colors.transparent,
                            borderWidth: 1,
                            borderColor: Theme.of(context).canvasColor,
                            borderRadius: 6.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                ImageView.svg(AppImages.icTransfer),
                                SizedBox(width: 10),
                                Text('Transfer',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                              ],
                            ))
                      ] else ...[
                        ButtonView(
                            onPressed: () => Modals.showBottomSheetModal(
                                  context,
                                  borderRadius: 25,
                                  heightFactor: 0.9,
                                  page: const FundWalletOverlay(
                                      btnText: 'Transfer',
                                      subTitle: 'Transfer your voucher earnings to main wallet',
                                      title: 'Transfer Voucher'),
                                  isScrollControlled: true,
                                ),
                            expanded: false,
                            color: Colors.transparent,
                            borderWidth: 1,
                            borderColor: Theme.of(context).canvasColor,
                            borderRadius: 6.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                ImageView.svg(AppImages.icTopUp),
                                SizedBox(width: 10),
                                Text('Transfer to wallet',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                              ],
                            ))
                      ]
                    ],
                  )
                ],
              )),
        ),
      ],
    );
  }
}
