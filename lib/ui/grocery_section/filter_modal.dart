import 'package:chow/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_toggle.dart';
import '../widgets/form_inputs.dart';
import '../widgets/image_view.dart';

class FilterModalContent extends StatefulWidget {
  const FilterModalContent({Key? key}) : super(key: key);

  @override
  State<FilterModalContent> createState() => _FilterModalContentState();
}

class _FilterModalContentState extends State<FilterModalContent> {
  List<String> values = [
    'All',
    'Fruits',
    'Special Offers',
    'Vegetables',
  ];
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = values.last;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Filter',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 24,
                weight: FontWeight.bold,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const ImageView.svg(
                  AppImages.dropDown,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Expanded(
          flex: 8,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              CustomText(
                text: 'Sort by',
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: 22,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 30,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: values.length,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 45,
                ),
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    value: values[index],
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    groupValue: selectedValue,
                    title: CustomText(
                      text: values[index],
                      maxLines: 2,
                      size: 16,
                      color: (selectedValue == values[index])
                          ? Theme.of(context).textTheme.bodyText1!.color
                          : Theme.of(context).textTheme.caption!.color,
                      weight: FontWeight.bold,
                    ),
                    activeColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (value) =>
                        setState(() => selectedValue = values[index]),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                text: 'Filter',
                color: Colors.black,
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              FormInput(
                controller: TextEditingController(text: ''),
                height: 45,
                label: 'Price',
                hint: 'Enter Price',
                onChanged: (value) {},
                prefixWiget: const CustomText(
                  text: 'NGN',
                  color: Colors.black,
                  size: 14,
                  weight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FormInput(
                controller: TextEditingController(text: ''),
                height: 45,
                label: 'Distance',
                hint: 'Enter Distance',
                onChanged: (value) {},
                prefixWiget: const CustomText(
                  text: 'KM',
                  color: AppColors.lightSecondaryAccent,
                  size: 14,
                  weight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 55,
              ),
              ButtonView(
                onPressed: () {},
                child: Center(
                  child: CustomText(
                    text: 'Apply',
                    color: Theme.of(context).primaryColor,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
