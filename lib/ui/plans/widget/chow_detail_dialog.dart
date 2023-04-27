import 'package:chow/extentions/custom_string_extension.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../model/data_models/product/product.dart';
import '../../../res/app_images.dart';
import '../../../utils/validator.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_time_picker.dart';
import '../../widgets/image_view.dart';
import '../../widgets/meal_detail.dart';
import '../../widgets/quantity_view.dart';

class ChowDetailDialog extends StatefulWidget {
  final Product product;
  const ChowDetailDialog(this.product, {Key? key}) : super(key: key);

  @override
  State<ChowDetailDialog> createState() => _ChowDetailDialogState();
}

class _ChowDetailDialogState extends State<ChowDetailDialog> {
  final _formKey = GlobalKey<FormState>();

  int _count = 1;

  late TimeOfDay _selectedTime;

  @override
  Widget build(BuildContext context) {
    return MealDetail(
        imageUrl: widget.product.image,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(
              height: 85,
            ),
            Text(widget.product.description.capitalizeFirstOfEach,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('widget.meal.restaurantName',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.caption!.color,
                        fontWeight: FontWeight.w400)),
                const SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Row(
                    children: const [
                      ImageView.svg(
                        AppImages.icClockTickOutline,
                        width: 20,
                      ),
                      SizedBox(width: 5),
                      CustomText(
                        weight: FontWeight.w400,
                        size: 14,
                        maxLines: 2,
                        text: '20 - 30 mins',
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            Text(
                AppUtils.convertPrice(widget.product.price, showCurrency: true),
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).textTheme.caption!.color,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 25),
            QuantityView(
              defaultCount: _count,
              onChange: (int count, state) => _count = count,
            ),
            const SizedBox(height: 35),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Set Delivery Time',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            ),
            const SizedBox(height: 10),
            Form(
                key: _formKey,
                child: CustomTimePicker(
                    hintText: 'Set time',
                    validator: Validator.validate,
                    onSelected: (TimeOfDay time) => _selectedTime = time)),
            const SizedBox(height: 35),
            ButtonView(
                onPressed: _submit,
                child: const Text('Set Meal',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18))),
            const SizedBox(height: 25),
            ButtonView(
                onPressed: _submit,
                borderWidth: 1,
                color: Colors.transparent,
                child: Text('Create Combo',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18)))
          ]),
        ));
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, [_count, _selectedTime, widget.product]);
    }
  }
}
