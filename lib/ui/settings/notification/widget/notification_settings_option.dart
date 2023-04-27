import 'package:flutter/material.dart';

import '../../../widgets/progress_indicator.dart';

class NotificationSettingsOption extends StatelessWidget {
  final bool value;
  final String caption;
  final bool processing;

  final ValueChanged<bool>? onChanged;
  const NotificationSettingsOption(
      {required this.value,
      required this.caption,
      this.onChanged,
      this.processing = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(caption,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        trailing: (processing)
            ? SizedBox(
                height: 16,
                width: 16,
                child: ProgressIndicators.circularProgressBar(context))
            : Switch(
                value: value,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: onChanged));
  }
}
