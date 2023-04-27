import 'dart:io';

import 'package:chow/res/app_images.dart';
import 'package:chow/ui/modals.dart';
import 'package:chow/ui/settings/profile/widget/edit_password_dialog.dart';
import 'package:chow/ui/settings/profile/widget/profile_detail_view.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/account/account.dart';
import '../../../handlers/image_handler.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../../res/enum.dart';
import '../../widgets/profile_image.dart';
import '../../widgets/progress_indicator.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (BuildContext context, UserViewModel viewModel, Widget? child) {
        final user = viewModel.user!;
        return BlocProvider<AccountCubit>(
            lazy: false,
            create: (_) => AccountCubit(
                accountRepository: AccountRepositoryImpl(),
                viewModel: Provider.of<UserViewModel>(context, listen: false)),
            child: BlocConsumer<AccountCubit, AccountStates>(
                listener: (context, state) {
                  if (state is AccountApiErr) {
                    if (state.message != null) {
                      Modals.showToast(state.message!,
                          messageType: MessageType.error);
                    }
                  } else if (state is AccountNetworkErr) {
                    if (state.message != null) {
                      Modals.showToast(state.message!,
                          messageType: MessageType.error);
                    }
                  } else if (state is AccountPinChanged) {
                    Modals.showToast(state.message,
                        messageType: MessageType.success);
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) => Scaffold(
                      appBar: AppBar(
                        title: const Text('Profile Settings',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24)),
                        centerTitle: true,
                        /*actions: [
                    IconButton(onPressed: (){},
                        icon: const Icon(Icons.more_vert)),
                    const SizedBox(width: 10)
                  ],*/
                      ),
                      body: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const SizedBox(height: 25),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ProfileImage(user.image,
                                  width: 140,
                                  height: 140,
                                  borderWidth: 1.5,
                                  radius: 70),
                              if (state is AccountProcessing) ...[
                                Center(
                                  child: ProgressIndicators.circularProgressBar(
                                      context),
                                )
                              ] else ...[
                                Positioned(
                                  right: 130,
                                  bottom: 10,
                                  child: InkWell(
                                    onTap: () async {
                                      final image =
                                          await ImageHandler.pickImage(context,
                                              image: true);
                                      if (image != null) {
                                        final croppedImage =
                                            await ImageHandler.cropImage(
                                                File(image.path));
                                        if (croppedImage != null) {
                                          context
                                              .read<AccountCubit>()
                                              .uploadAccountImage(
                                                  File(croppedImage.path));
                                        }
                                      }
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1.5,
                                              color: Theme.of(context)
                                                  .dividerColor),
                                        ),
                                        child: const ImageView.svg(
                                            AppImages.icUpload,
                                            height: 34,
                                            width: 34)),
                                  ),
                                )
                              ]
                            ],
                          ),
                          const SizedBox(height: 25),
                          Card(
                              elevation: 5,
                              margin: EdgeInsets.zero,
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(15.0),
                                children: [
                                  ProfileDetailView(
                                      caption: 'First name',
                                      value: user.firstName ?? ''),
                                  ProfileDetailView(
                                      caption: 'Surname',
                                      value: user.lastName ?? ''),
                                  ProfileDetailView(
                                      caption: 'Phone Number',
                                      showAction: false,
                                      value: user.phone),
                                  ProfileDetailView(
                                      caption: 'Email',
                                      value: user.userEmail,
                                      actionText: user.emailTitle),
                                  ProfileDetailView(
                                      caption: 'Password',
                                      value: user.password,
                                      action: () => Modals.showBottomSheetModal(
                                          context,
                                          heightFactor: 1,
                                          page: const EditPasswordDialog()))
                                ],
                              ))
                        ],
                      ),
                    )));
      },
    );
  }
}
