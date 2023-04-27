import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../res/app_routes.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/dropdown_view.dart';
import '../../widgets/image_view.dart';

class DeliveryOption extends StatefulWidget {
  final String address;
  const DeliveryOption({Key? key, required this.address}) : super(key: key);

  @override
  State<DeliveryOption> createState() => _DeliveryOptionState();
}

class _DeliveryOptionState extends State<DeliveryOption> {
  List<String> values = [
    'Deliver to address',
    'Delivery Options',
  ];

  late String selectedValue;
  final selectedColor = AppColors.lightSecondaryAccent;
  final unselectedColor = AppColors.lightPrimary;

  String? _addressDropdownValue;
  final List<String> _addressSpinnerItems = [];

  int isSelectedIndex = -1;

  void _isSelected({required int index}) {
    setState(() {
      isSelectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedValue = values.first;
    _addressSpinnerItems.add(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Delivery Options',
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: 24,
              weight: FontWeight.w600,
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              children: List.generate(values.length, (index) {
                return RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  value: values[index],
                  groupValue: selectedValue,
                  title: CustomText(
                    text: values[index],
                    size: 18,
                    color: (selectedValue == values[index])
                        ? Theme.of(context).textTheme.bodyText1!.color
                        : Theme.of(context).textTheme.caption!.color,
                    weight: FontWeight.w600,
                  ),
                  activeColor: selectedColor,
                  onChanged: (value) =>
                      setState(() => selectedValue = values[index]),
                );
              }),
            ),
            const SizedBox(
              height: 25,
            ),
            DropdownView.form(
                borderColor: Colors.transparent,
                fillColor: Theme.of(context).shadowColor,
                filled: false,
                borderRadius: 6.0,
                borderWidth: 0,
                isDense: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ImageView.svg(AppImages.icLocation),
                ),
                value: _addressDropdownValue,
                items: _addressSpinnerItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: Validator.validate,
                hintText: 'Select',
                onChanged: (String? value) =>
                    setState(() => _addressDropdownValue = value!)),
            const SizedBox(
              height: 19,
            ),
            ButtonView(
                color: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).shadowColor,
                onPressed: () {
                  AppNavigator.pushAndStackNamed(context,
                      name: AppRoutes.setLocationScreen);
                },
                borderRadius: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width: 20, child: ImageView.svg(AppImages.icAdd)),
                    const SizedBox(
                      width: 24.34,
                    ),
                    CustomText(
                      text: 'Set Location',
                      color: Theme.of(context).colorScheme.secondary,
                      textAlign: TextAlign.center,
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                  ],
                )),
          ],
        ));
  }

  locationOverlay() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Choose Location',
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  textAlign: TextAlign.center,
                  size: 24,
                  weight: FontWeight.w600,
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const ImageView.svg(AppImages.dropDown))
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _isSelected(index: index);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 14, bottom: 30),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.lightShadowColor,
                                    width: 1))),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 8,
                              child: CustomText(
                                maxLines: 3,
                                text: 'Uduma street, New Heaven, Enugu.',
                                color: (isSelectedIndex == index)
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color
                                    : Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .color,
                                textAlign: TextAlign.start,
                                size: 18,
                                weight: (isSelectedIndex == index)
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            (isSelectedIndex == index)
                                ? const ImageView.svg(AppImages.icTick)
                                : Container()
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const Spacer(),
            ButtonView(
                color: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).shadowColor,
                onPressed: () {},
                borderRadius: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width: 20, child: ImageView.svg(AppImages.icAdd)),
                    const SizedBox(
                      width: 24.34,
                    ),
                    CustomText(
                      text: 'Set Location',
                      color: Theme.of(context).colorScheme.secondary,
                      textAlign: TextAlign.center,
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                  ],
                )),
          ],
        ),
      );
    });
  }
}
