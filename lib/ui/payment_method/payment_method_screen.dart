import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../widgets/custom_text.dart';
import '../widgets/image_view.dart';
import 'widget/payment_method_chioce.dart';
import 'widget/payment_method_pages.dart';
import 'widget/promo_code_field.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String? amount;
  const PaymentMethodScreen({this.amount, Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final GlobalKey<PaymentChoiceCardState> _key =
      GlobalKey<PaymentChoiceCardState>();

  int initPageIndex = 0;
  bool voucherState = true;

  _isVoucherPayment() {
    setState(() {
      voucherState = !voucherState;
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      PaymentChoiceCard.indexNotifier.listen((event) {
        setState(() {
          initPageIndex = event;
        });
      }, cancelOnError: false);
    } catch (e) {
      //print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amount =
        widget.amount ?? ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: CustomText(
            size: 24,
            text: 'Make Payment',
            color: Theme.of(context).textTheme.bodyText1!.color,
            weight: FontWeight.w700,
          ),
        ),
        body: ListView(shrinkWrap: true, children: [
          const SizedBox(height: 23),
          InkWell(
            onTap: _isVoucherPayment,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(children: [
                (voucherState)
                    ? const ImageView.svg(AppImages.icCheck)
                    : const ImageView.svg(AppImages.icUncheck),
                const SizedBox(width: 6),
                CustomText(
                  size: 18,
                  text: 'Pay with voucher',
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  weight: FontWeight.w500,
                ),
              ]),
            ),
          ),
          const SizedBox(height: 26),
          (voucherState)
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.0),
                  child: PromoCodeField(),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 37),
          PaymentChoiceCard(key: _key),
          const SizedBox(height: 18),
          IndexedStack(
            index: initPageIndex,
            children: [
              PaymentMethodPages.wallet(amount: amount),
              PaymentMethodPages.card(amount: amount),
              // PaymentMethodPages.bank(amount: amount),
            ],
          ),
        ]));
  }
}
