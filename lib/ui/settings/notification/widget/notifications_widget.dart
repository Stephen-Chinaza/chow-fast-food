import 'package:flutter/material.dart';

import '../../../../model/data_models/notifications/get_notifications.dart';
import '../../../../utils/app_utils.dart';
import 'notification_card.dart';

class NotificationsWidget extends StatelessWidget {
  final String caption;
  final List<GetNotifications> notifications;
  const NotificationsWidget(
      {required this.caption, Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(caption,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
        const SizedBox(height: 8),
        (notifications.isEmpty)
            ? SizedBox(
                height: 120,
                child: Center(
                    child: Text('No Active Notifications',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.secondary,
                        ))),
              )
            : ListView.builder(
                itemCount: notifications.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final notificationsList = notifications[index];
                  return NotificationCard(
                      title: notificationsList.title,
                      detail: notificationsList.message,
                      time: AppUtils.formatComplexDate(
                          dateTime:
                              notificationsList.createdAt.toIso8601String()),
                      read: notificationsList.read);
                },
              ),
      ],
    );
  }
}
