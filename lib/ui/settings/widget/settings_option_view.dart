import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

class SettingsOptionView extends StatelessWidget {
  final String icon;
  final String caption;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  const SettingsOptionView({required this.icon,
    required this.caption,
    this.onTap,
    this.trailing,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=>Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shadowColor: Theme.of(context).shadowColor,
      margin: const EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
      ),
      child: ListTile(
        onTap: onTap,
        leading: ImageView.svg(
            icon
        ),
        title: Text(caption,
            style: TextStyle(fontSize: 18,
                color: Theme.of(context).textTheme.caption!.color,
                fontWeight: FontWeight.w600)),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios,
            size: 12),
      ));
}