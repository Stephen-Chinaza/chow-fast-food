import 'package:chow/model/data_models/app_service.dart';
import 'package:chow/res/app_images.dart';
import 'package:chow/res/app_routes.dart';
import 'package:chow/ui/home/widgets/service_card.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../widgets/responsive_widget.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final services = <AppService>[
      AppService(
          caption: 'Food',
          icon: AppImages.icFood,
          voidCallback: () => AppNavigator.pushAndStackNamed(context,
              name: AppRoutes.foodScreen)),
      AppService(
          caption: 'Drinks',
          icon: AppImages.icDrinks,
          voidCallback: () => AppNavigator.pushAndStackNamed(context,
              name: AppRoutes.drinksScreen)),
      AppService(
          caption: 'Groceries',
          icon: AppImages.icGroceries,
          voidCallback: () => AppNavigator.pushAndStackNamed(context,
              name: AppRoutes.groceryScreen)),
      AppService(
          caption: 'Pharmacy',
          icon: AppImages.icPharmacy,
          voidCallback: () => AppNavigator.pushAndStackNamed(context,
              name: AppRoutes.pharmacyScreen))
    ];

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 2 : 4,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: services.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext ctx, index) {
          return ServiceCard(services[index]);
        });
  }
}
