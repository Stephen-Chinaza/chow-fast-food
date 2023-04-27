import 'package:chow/extentions/custom_string_extension.dart';
import 'package:chow/res/app_routes.dart';
import 'package:chow/res/app_strings.dart';
import 'package:chow/ui/modals.dart';
import 'package:chow/ui/settings/widget/settings_option_view.dart';
import 'package:chow/ui/settings/widget/setting_dialog.dart';
import 'package:chow/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/account/account.dart';
import '../../model/view_models/user_view_model.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/enum.dart';
import '../widgets/cart_icon.dart';
import '../widgets/profile_image.dart';
import 'widget/verification_view.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (BuildContext context, UserViewModel viewModel, Widget? child) {
        final user = viewModel.user!;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            image: const DecorationImage(
                image: AssetImage(AppImages.bgAppbar),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter
            ),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text('Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor
                    )),
                actions: [
                  CartIcon(color: Theme.of(context).primaryColor)
                ],
              ),
              body: BlocConsumer<AccountCubit, AccountStates>(
                  listener: (context, state) {
                    if(state is AccountProcessing){

                    }else if(state is AccountNetworkErr){
                      if(state.message!=null) {
                        Modals.showToast(state.message!,
                            messageType: MessageType.error);
                      }
                    }else if(state is AccountApiErr){
                      if(state.message!=null) {
                        Modals.showToast(state.message!,
                            messageType: MessageType.error);
                      }
                    }else if(state is AccountLoggedOut){
                      AppNavigator.pushNamedAndRemoveUntil(context,
                          name: AppRoutes.welcomeScreen);
                    }
                  },
                  builder: (context, state)=>Stack(
                    children: [
                      Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(25.0)),
                          ),
                          margin: const EdgeInsets.only(top: 70),
                          child: Column(
                            children: [
                              const SizedBox(height: 70),
                              Text('${user.firstName} ${user.lastName}'.capitalizeFirstOfEach,
                                  style: const TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 5),
                              Text(user.phone,
                                  style: TextStyle(fontSize: 18,
                                      color: Theme.of(context).textTheme.caption!.color,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 10),
                              VerificationView(user.verificationStatus),
                              const SizedBox(height: 20),
                              Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  color: Theme.of(context).backgroundColor,
                                  child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0,
                                          vertical: 8.0),
                                      children: [
                                        SettingsOptionView(icon: AppImages.icTrackOutline,
                                            caption: 'Track Order',
                                            onTap: ()=>AppNavigator.pushAndStackNamed(context,
                                                name: AppRoutes.trackOrderScreen)),
                                        SettingsOptionView(icon: AppImages.icPaymentOutline,
                                            caption: 'Payment Method',
                                            onTap: (){}),
                                        SettingsOptionView(icon: AppImages.icLocationOutline,
                                            caption: 'Delivery Address',
                                            onTap: (){}),
                                        SettingsOptionView(icon: AppImages.icNotificationOutline,
                                            caption: 'Notification',
                                            onTap: ()=>AppNavigator.pushAndStackNamed(context,
                                                name: AppRoutes.notificationScreen)),
                                        SettingsOptionView(icon: AppImages.icInviteOutline,
                                            caption: 'Invite Friends',
                                            onTap: (){}),
                                        SettingsOptionView(icon: AppImages.icSettingOutline,
                                            caption: 'Settings',
                                            onTap: ()=>Modals.showBottomSheetModal(context,
                                                page: const SettingsDialog())),
                                        SettingsOptionView(icon: AppImages.icHelpOutline,
                                            caption: 'Help/Feedback',
                                            onTap: (){}),
                                        SettingsOptionView(icon: AppImages.icLogoutOutline,
                                            caption: 'Logout',
                                            onTap: ()async=>await Modals.showAlertOptionDialog(context,
                                                title: 'Logout', message: AppStrings.logoutMessage).
                                            then((result){
                                              if(result!=null && result){
                                                context.read<AccountCubit>().logoutUser();
                                              }
                                            }))
                                      ]
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: ProfileImage(user.image,
                              height: 104,
                              width: 104,
                              borderWidth: 5,
                              borderColor: AppColors.yellow,
                              margin: const EdgeInsets.all(5.0),
                              radius: 50))
                    ],
                  )
              )
          ),
        );
      },
    );
  }
}
