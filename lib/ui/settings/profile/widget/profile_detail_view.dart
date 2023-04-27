

import 'package:chow/ui/modals.dart';
import 'package:chow/ui/settings/profile/widget/edit_profile_dialog.dart';
import 'package:flutter/material.dart';

class ProfileDetailView extends StatelessWidget {
  final String caption;
  final String value;
  final String actionText;
  final void Function()? action;
  final bool showAction;
  const ProfileDetailView({
    required this.caption,
    required  this.value,
    this.actionText='Edit',
    this.showAction=true,
    this.action, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(caption,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Theme.of(context).textTheme.caption!.color
            )),
      ),
      subtitle: Text(value,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyText1!.color
          )),
      trailing: Builder(
        builder: (context) {
          if(showAction){
            return InkWell(
              onTap: action ?? ()=>Modals.showBottomSheetModal(
                  context,
                  heightFactor: 0.55,
                  page: EditProfileDialog(title: '$actionText $caption')),
              child: Text(actionText,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary
                  )),
            );
          }
          return const SizedBox.shrink();
        }
      )
    );
  }
}
