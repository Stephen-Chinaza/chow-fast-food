import 'package:flutter/cupertino.dart';

class AppService{
  final String caption;
  final String icon;
  final VoidCallback? voidCallback;

  AppService({required this.caption, required this.icon, this.voidCallback});

  AppService copyWith({
    String? title,
    String? icon,
    Widget? page,
    Color? color,
    VoidCallback? voidCallback
  }){
    return AppService(caption: title ?? this.caption,
        icon: icon ?? this.icon,
        voidCallback: voidCallback ?? this.voidCallback);
  }
}