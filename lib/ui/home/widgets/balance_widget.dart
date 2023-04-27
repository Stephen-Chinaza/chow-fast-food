import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/user_view_model.dart';
import 'balance_card.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {

  final _controller=PageController(initialPage: 0, viewportFraction: 0.95);

  int _selectedIndex=0;

  void _next(int index)=>_controller.animateToPage(
      index, duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (BuildContext context, UserViewModel viewModel,
          Widget? child) => SizedBox(
          height: 150,
          child: PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index)=>setState(()=>_selectedIndex=index),
            children: [
              BalanceCard.wallet(isSelected: _selectedIndex==0,
                  balance: viewModel.walletBalance,
                  onEdgeTap: ()=>_next(0)),
              BalanceCard.voucher(isSelected: _selectedIndex==1,
                  balance: viewModel.walletBalance,
                  onEdgeTap: ()=>_next(1)),
            ], // Can be null
          )),
    );
  }
}
