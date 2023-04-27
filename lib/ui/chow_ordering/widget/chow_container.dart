import 'package:chow/res/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../res/app_images.dart';
import '../../../res/enum.dart';
import '../../modals.dart';
import '../../plans/widget/choose_action_dialog.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import 'select_combo_overlay.dart';

class ChowContainer extends StatefulWidget {
  final int dataLength;
  final int index;
  final Food foodItem;
  final String vendorId;
  final Function(int index, String edit)? onEdit;
  final Function(int index, String change)? onChange;
  final Function(int index)? onRemove;
  const ChowContainer(
      {Key? key,
      required this.dataLength,
      required this.foodItem,
      required this.vendorId,
      this.onEdit,
      this.onChange,
      this.onRemove,
      required this.index})
      : super(key: key);

  @override
  State<ChowContainer> createState() => _ChowContainerState();
}

class _ChowContainerState extends State<ChowContainer> {
  String change = 'change';

  @override
  Widget build(BuildContext context) {
    String percentageTag =
        (widget.foodItem.category == 'swallow') ? '  Rap' : '%  by mixture';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: (widget.foodItem.image == '')
                      ? const ImageView.asset(
                          AppImages.icon,
                          height: 65,
                          width: 65,
                        )
                      : ImageView.network(widget.foodItem.image,
                          height: 75, width: 75, fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CustomText(
                          text: widget.foodItem.name,
                          color: Colors.black,
                          size: 16,
                          weight: FontWeight.w700,
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Modals.showBottomSheetModal(context,
                                        heightFactor: 0.7,
                                        borderRadius: 25,
                                        page: const ChooseActionDialog())
                                    .then((result) {
                                  if (result != null) {
                                    switch (result) {
                                      case 'edit':
                                        {
                                          if (widget.onEdit != null) {
                                            widget.onEdit!(
                                                widget.index, 'edit');
                                          }
                                          break;
                                        }
                                      case 'change':
                                        {
                                          if (widget.onChange != null) {
                                            widget.onChange!(
                                                widget.index, 'change');
                                          }
                                          break;
                                        }
                                      case 'delete':
                                        {
                                          if (widget.onRemove != null) {
                                            widget.onRemove!(widget.index);
                                          }
                                          break;
                                        }
                                    }
                                  }
                                }),
                            child: const Icon(Icons.more_vert, size: 28)),
                      ]),
                      const SizedBox(height: 4),
                      CustomText(
                        text:
                            '${widget.foodItem.percentage.toString()}$percentageTag',
                        color: AppColors.red,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  editSelectedMeal(BuildContext context, id) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text('Choose action',
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontWeight: FontWeight.w800)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(right: 14.33, top: 21.82),
                  child: ImageView.svg(
                    AppImages.dropDown,
                    color: Color.fromARGB(255, 4, 90, 7),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              const SizedBox(height: 40),
              choiceAction(context, 'Edit Item', Icons.edit_outlined,
                  const Color.fromARGB(255, 4, 90, 7), () {}),
              const SizedBox(height: 30),
              choiceAction(context, 'Change Item', Icons.sync_alt,
                  const Color.fromARGB(255, 43, 72, 236), () {}),
              const SizedBox(height: 30),
              choiceAction(
                  context,
                  'Delete Item',
                  Icons.delete_outline_outlined,
                  const Color.fromARGB(255, 238, 62, 62),
                  () {}),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  choiceAction(BuildContext context, String title, IconData iconData,
      Color color, Function onPressed) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: 28,
        ),
        const SizedBox(
          width: 22,
        ),
        Text(title,
            style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontWeight: FontWeight.w800)),
      ],
    );
  }
}
