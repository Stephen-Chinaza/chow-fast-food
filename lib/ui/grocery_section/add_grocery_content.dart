import 'package:flutter/material.dart';

import '../../../res/app_routes.dart';
import '../../../utils/navigator/page_navigator.dart';

import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/quantity_view.dart';

class AddGroceryContent extends StatelessWidget {
  final Function()? addOnPressed;
  const AddGroceryContent({Key? key, this.addOnPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      const SizedBox(
        height: 85,
      ),
      Center(
        child: Text('Green Avocado',
            style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontWeight: FontWeight.w700)),
      ),
      const SizedBox(height: 20),
      Center(
        child: Text('Fresh & Green',
            style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.caption!.color,
                fontWeight: FontWeight.w400)),
      ),
      const SizedBox(height: 47),
      Center(
        child: Text('NGN 2,500',
            style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).textTheme.caption!.color,
                fontWeight: FontWeight.w600)),
      ),
      const SizedBox(height: 35),
      const Align(alignment: Alignment.center, child: QuantityView()),
      const SizedBox(height: 78),
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 31.0),
          child: ButtonView(
            onPressed: () =>
                addOnPressed ??
                AppNavigator.pushAndStackNamed(context,
                    name: AppRoutes.groceryDetailsScreen),
            child: Center(
              child: CustomText(
                text: 'Add to Cart',
                color: Theme.of(context).primaryColor,
                size: 18,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 35),
    ]);
  }
}
