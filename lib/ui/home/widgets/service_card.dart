import 'package:chow/model/data_models/app_service.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final AppService service;

  const ServiceCard(this.service,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: service.voidCallback,
      child: Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          shadowColor: Theme.of(context).shadowColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                ImageView.svg(service.icon),
                const Spacer(),
                Text(service.caption,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                const Spacer(),
              ],
            ),
          )),
    );
  }
}
