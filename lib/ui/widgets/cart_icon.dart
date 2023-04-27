import 'package:chow/model/view_models/products_view_model.dart';
import 'package:chow/res/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/app_images.dart';
import '../../utils/navigator/page_navigator.dart';
import 'badger_icon.dart';
import 'image_view.dart';

class CartIcon extends StatelessWidget {
  final Color? color;
  final void Function()? onPressed;
  const CartIcon({this.color, Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsViewModel>(builder:
        (BuildContext context, ProductsViewModel viewModel, Widget? child) {
      return InkWell(
        onTap: onPressed ??
            () => AppNavigator.pushAndStackNamed(context,
                name: AppRoutes.cartScreen, arguments: 'drinks_cart'),
        child: BadgerIcon(
            count: viewModel.cartCount,
            icon: ImageView.svg(AppImages.icCart, color: color)),
      );
    });
  }
}
