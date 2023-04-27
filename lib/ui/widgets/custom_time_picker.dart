import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../res/app_images.dart';
import 'image_view.dart';
import 'text_edit_view.dart';


class CustomTimePicker extends StatefulWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final bool isDense;
  final double borderWidth;
  final String timeFormat;
  final Color? pickerColor;
  final FormFieldValidator<String>? validator;
  final void Function(TimeOfDay time)? onSelected;
  const CustomTimePicker({
    this.hintText,
    this.prefixIcon,
    this.isDense=true,
    this.borderWidth=0,
    this.timeFormat='hh:mm a',
    this.pickerColor,
    this.validator,
    this.onSelected, Key? key})
      : super(key: key);

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {

  late DateFormat dateFormat;

  final timeController=TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext? context, Widget? child) {
          return Theme(
              data: Theme.of(context!).copyWith(
                  colorScheme:  ColorScheme.light(
                      primary: widget.pickerColor
                          ?? Theme.of(context).colorScheme.secondary
                  )
              ),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!,
              )
          );
        });

    if (picked != null && picked != selectedTime ){
      selectedTime = picked;
      timeController.text=picked.format(context);
      if(widget.onSelected!=null) widget.onSelected!(picked);
    }
  }


  @override
  Widget build(BuildContext context) {
    return TextEditView(
        controller: timeController,
        keyboardType: TextInputType.none,
        textInputAction: TextInputAction.none,
        hintText: widget.hintText,
        borderWidth: widget.borderWidth,
        isDense: widget.isDense,
        readOnly: true,
        validator: widget.validator,
        onTap: ()=>_selectTime(context),
        prefixIcon: widget.prefixIcon ?? const Padding(
          padding: EdgeInsets.all(15.0),
          child: ImageView.svg(AppImages.icClock),
        )
    );
  }
}
