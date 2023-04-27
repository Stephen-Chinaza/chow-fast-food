import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';
import 'widget/payment_method_chioce.dart';
import 'widget/payment_method_pages.dart';

class TopUpScreen extends StatefulWidget {
  final String? amount;
  const TopUpScreen({this.amount, Key? key}) : super(key: key);

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  int initPageIndex = 0;

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
            text: 'Top up',
            color: Theme.of(context).textTheme.bodyText1!.color,
            weight: FontWeight.w700,
          ),
        ),
        body: ListView(shrinkWrap: true, children: [
          const SizedBox(height: 37),
          const PaymentChoiceCard(isTopupPage: true),
          const SizedBox(height: 18),
          IndexedStack(
            index: initPageIndex,
            children: [
              PaymentMethodPages.card(isTopUpPage: true, amount: amount),
              // PaymentMethodPages.bank(amount: amount),
            ],
          ),
        ]));
  }
}
