import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType inputType;
  final int maxLines;
  final double width;
  final double height;
  final bool isEnabled;
  final Widget prefixWiget;
  final ValueChanged<String>? onChanged;

  const FormInput(
      {Key? key,
      required this.controller,
      this.label = '',
      this.hint = '',
      this.width = double.infinity,
      this.height = 45,
      this.inputType = TextInputType.text,
      this.maxLines = 1,
      this.isEnabled = true,
      this.onChanged,
      this.prefixWiget = const SizedBox.shrink()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        const SizedBox(
          height: 8,
        ),
        Material(
          elevation: 0,
          color: Colors.black12,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.only(right: 16, left: 16, bottom: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Center(
              child: TextField(
                  controller: controller,
                  keyboardType: inputType,
                  maxLines: maxLines,
                  enabled: isEnabled,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: prefixWiget,
                      ),
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16)),
                  onChanged: onChanged),
            ),
          ),
        ),
      ],
    );
  }
}
