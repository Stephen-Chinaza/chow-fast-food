import 'package:chow/extentions/custom_string_extension.dart';
import 'package:chow/model/view_models/user_view_model.dart';
import 'package:chow/res/app_images.dart';
import 'package:chow/ui/home/widgets/balance_widget.dart';
import 'package:chow/ui/home/widgets/referral_card.dart';
import 'package:chow/ui/home/widgets/services_widget.dart';
import 'package:chow/ui/widgets/badger_icon.dart';
import 'package:chow/ui/widgets/cart_icon.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:chow/ui/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/app_routes.dart';
import '../../utils/navigator/page_navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: false).user!;
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: ProfileImage(user.image)),
        title: Text('Hi ${user.firstName!.capitalizeFirstOfEach}!'),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: const [
          BadgerIcon(icon: ImageView.svg(AppImages.icSearch)),
          CartIcon(),
          SizedBox(width: 10)
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () => AppNavigator.pushAndStackNamed(context,
                          name: AppRoutes.setLocationScreen),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ImageView.svg(AppImages.icLocation),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(user.location!.capitalizeFirstOfEach,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    )),
                const SizedBox(height: 25),
                const Text('What will you have chow do for you today?',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 25),
              ],
            ),
          ),
          const BalanceWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ServicesWidget(),
                ),
                SizedBox(height: 15),
                ReferralCard(),
                SizedBox(height: 15)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
