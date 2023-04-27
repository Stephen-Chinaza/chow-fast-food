import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../handlers/location_handler.dart';
import 'progress_indicator.dart';

class CountryCodeView extends StatefulWidget {
  final ValueChanged<CountryCode> onChanged;
  final String? initialSelection;
  final bool showCountryOnly;
  final bool showOnlyCountryWhenClosed;
  final bool showFlag;
  final bool showFlagMain;
  final bool showFlagDialog;
  final bool alignLeft;
  final Color? textColor;
  const CountryCodeView(
      {required this.onChanged,
      required this.initialSelection,
      this.showCountryOnly = false,
      this.showOnlyCountryWhenClosed = false,
      this.textColor,
        this.showFlag=true,
        this.showFlagDialog=true,
        this.showFlagMain=true,
        this.alignLeft=false,
      Key? key})
      : super(key: key);

  @override
  State<CountryCodeView> createState() => _CountryCodeViewState();
}

class _CountryCodeViewState extends State<CountryCodeView> {
  String? _initialSelection;

  @override
  void initState() {
    if (widget.initialSelection == null) {
      LocationHandler.getUserAddress().then((placeMark) {
        if (placeMark.country != null) {
          setState(() {
            _initialSelection = placeMark.country!;
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialSelection != null) {
      _initialSelection = widget.initialSelection;
    }
    if (_initialSelection == null) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ProgressIndicators.circularProgressBar(context),
      );
    }
    return CountryCodePicker(
      onChanged: widget.onChanged,
      onInit: (CountryCode? v) =>
          Future.delayed(const Duration(milliseconds: 100))
              .whenComplete(() => widget.onChanged(v!)),
      initialSelection: _initialSelection,
      favorite: const ['+234', 'NG'],
      showCountryOnly: widget.showCountryOnly,
      showOnlyCountryWhenClosed: widget.showOnlyCountryWhenClosed,
      alignLeft: widget.alignLeft,
      showFlag: widget.showFlag,
      showFlagMain: widget.showFlagMain,
      showFlagDialog: widget.showFlagDialog,
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      showDropDownButton: true,
      textStyle:
          widget.textColor != null ? TextStyle(color: widget.textColor) : null,
      searchDecoration: InputDecoration(
          prefixIcon: Icon(Icons.search,
              color: Theme.of(context).colorScheme.secondary),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary, width: 1.5),
          )),
      boxDecoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(25.0)),
    );
  }
}
