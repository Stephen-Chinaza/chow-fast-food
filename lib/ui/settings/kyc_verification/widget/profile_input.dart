import 'package:flutter/material.dart';

class ProfileInputField extends StatelessWidget {
  final String label;
  final Widget child;
  final bool isRequired;
  const ProfileInputField({Key? key,
    this.isRequired=true,
    required this.label,
    required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context)=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text.rich(TextSpan(children: [
        TextSpan(
            text: label,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18)),
        if(isRequired)...[
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0, -2),
              child: Text('*',
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
            ),
          )
        ]
      ])),
      const SizedBox(height: 8.0),
      child
    ],
  );
}
