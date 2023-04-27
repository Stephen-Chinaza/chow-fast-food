import 'package:chow/res/app_images.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

class ChooseActionDialog extends StatelessWidget {
  const ChooseActionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text('Choose action',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600))),
              const SizedBox(width: 5),
              Align(
                alignment: Alignment.topRight,
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
              leading: const ImageView.svg(AppImages.icEditOutline),
              title: const Text('Edit Item',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
              onTap: () => Navigator.pop(context, 'edit')),
          ListTile(
              leading: const ImageView.svg(AppImages.icChange),
              title: const Text('Change Item',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
              onTap: () => Navigator.pop(context, 'change')),
          ListTile(
              leading: const ImageView.svg(AppImages.icDeleteOutline),
              title: const Text('Delete Item',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
              onTap: () => Navigator.pop(context, 'delete'))
        ],
      ),
    );
  }
}
