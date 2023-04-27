import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../res/app_images.dart';
import 'image_view.dart';
import 'text_edit_view.dart';


class CustomDatePicker extends StatefulWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final bool isDense;
  final double borderWidth;
  final String dateFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color? pickerColor;
  final FormFieldValidator<String>? validator;
  final void Function(DateTime dateTime)? onSelected;
  final Iterable<String>? autofillHints;
  const CustomDatePicker({
    this.hintText,
    this.prefixIcon,
    this.isDense=true,
    this.borderWidth=0,
    this.dateFormat='yyyy-MM-dd',
    this.firstDate,
    this.lastDate,
    this.pickerColor,
    this.validator,
    this.autofillHints,
    this.onSelected, Key? key})
      : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {

  late DateFormat dateFormat;

  final dateController=TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: widget.firstDate ?? DateTime.now().
        add(const Duration(days: -50000)),
        lastDate: widget.lastDate ?? DateTime.now().
        add(const Duration(days: 90000)),
        builder: (BuildContext? context, Widget? child){
          return Theme(
            data: Theme.of(context!).copyWith(
                colorScheme:  ColorScheme.light(
                    primary: widget.pickerColor
                        ?? Theme.of(context).colorScheme.secondary
                )
            ),
            child: child!
          );
        });
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text=dateFormat.format(picked);
      if(widget.onSelected!=null) widget.onSelected!(picked);
    }
  }

  @override
  void initState() {
    dateFormat=DateFormat(widget.dateFormat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextEditView(
        controller: dateController,
        keyboardType: TextInputType.none,
        textInputAction: TextInputAction.none,
        hintText: widget.hintText,
        borderWidth: widget.borderWidth,
        isDense: widget.isDense,
        readOnly: true,
        validator: widget.validator,
        autofillHints: widget.autofillHints,
        onTap: ()=>_selectDate(context),
        prefixIcon: widget.prefixIcon ?? const Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
          child: ImageView.svg(AppImages.icCalendar),
        )
    );
  }
}
