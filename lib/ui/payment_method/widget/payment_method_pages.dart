import 'package:chow/res/enum.dart';
import 'package:chow/ui/payment_method/widget/card_payment_screen.dart';
import 'package:chow/ui/payment_method/widget/wallet_payment_page.dart';
import 'package:flutter/material.dart';

import 'bank_payment_screen.dart';

class PaymentMethodPages extends StatefulWidget {
  final PaymentMethod? method;
  final bool? isTopUpPage;
  final String amount;
  const PaymentMethodPages.wallet(
      {Key? key, required this.amount, this.isTopUpPage = false})
      : method = PaymentMethod.wallet, super(key: key);
  const PaymentMethodPages.card(
      {Key? key, required this.amount, this.isTopUpPage = false})
      : method = PaymentMethod.card, super(key: key);
  const PaymentMethodPages.bank(
      {Key? key, required this.amount, this.isTopUpPage = false})
      : method = PaymentMethod.bank, super(key: key);

  @override
  State<PaymentMethodPages> createState() => _PaymentMethodPagesState();
}

class _PaymentMethodPagesState extends State<PaymentMethodPages> {
  @override
  Widget build(BuildContext context) {
    if (widget.method == PaymentMethod.wallet) {
      return WalletDetailsPage(amount: widget.amount);
    } else if (widget.method == PaymentMethod.card) {
      return CardDetailsScreen(
        isTopUpPage: widget.isTopUpPage!,
        amount: widget.amount);
    } else if (widget.method == PaymentMethod.bank) {
      return const BankPaymentScreen();
    }
    return const SizedBox.shrink();
  }
}
