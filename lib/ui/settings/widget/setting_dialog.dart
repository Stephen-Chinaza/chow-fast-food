
import 'package:chow/res/app_images.dart';
import 'package:chow/res/app_routes.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';


class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(child: Text('Settings',
                style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.w600))),
              const SizedBox(width: 5),
              Align(alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const ImageView.svg(
                    AppImages.dropDown,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          ListTile(
            leading: const ImageView.svg(AppImages.icPerson),
            title: const Text('Profile Settings',
                style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 18)),
            onTap: (){
              Navigator.pop(context);
              AppNavigator.pushAndStackNamed(context,
                  name: AppRoutes.profileSettingScreen);
            }
          ),
          ListTile(
            leading: const ImageView.svg(AppImages.icNotification),
            title: const Text('Notification Settings',
                style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 18)),
              onTap: (){
                Navigator.pop(context);
                AppNavigator.pushAndStackNamed(context,
                    name: AppRoutes.notificationSettingScreen);
              }
          )
        ],
      ),
    );
  }
}
