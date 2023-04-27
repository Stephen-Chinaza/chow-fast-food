
import 'package:flutter/material.dart';

import '../../../../res/app_images.dart';
import '../../../widgets/image_view.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String detail;
  final String time;
  final bool read;
  const NotificationCard({
    required this.title,
    required this.detail,
    required this.time,
    this.read=false,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ImageView.svg(AppImages.icNotificationGift),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(title,
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: read ? Theme.of(context).textTheme.caption!.color
                                        : Theme.of(context).textTheme.bodyText1!.color,
                                    fontSize: 16)),
                          ),
                          InkWell(child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.more_horiz),
                          ), onTap: (){})
                        ],
                      ),
                      Text(detail,
                          style: TextStyle(fontWeight: FontWeight.w400,
                              color: read ? Theme.of(context).textTheme.caption!.color
                                  : Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 14)),
                      const SizedBox(height: 15),
                      Text(time,
                          style: TextStyle(fontWeight: FontWeight.w600,
                              color: read ? Theme.of(context).textTheme.caption!.color
                                  : Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 12))
                    ],
                  ),
                )
              ],
            )
        ));
  }
}
