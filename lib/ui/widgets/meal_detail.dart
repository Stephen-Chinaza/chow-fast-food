import 'package:chow/res/app_images.dart';
import 'package:flutter/material.dart';

import 'image_view.dart';
import 'profile_image.dart';

class MealDetail extends StatelessWidget {
  final Widget child;
  final String? imageUrl;
  const MealDetail(
      {Key? key, required this.child, this.imageUrl = AppImages.food4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        color: Theme.of(context).primaryColor,
        image: const DecorationImage(
            image: AssetImage(AppImages.bgAppbar),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(right: 14.33, top: 21.82),
                  child: ImageView.svg(
                    AppImages.dropDown,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  margin: const EdgeInsets.only(top: 100),
                  child: child),
              Align(
                  alignment: Alignment.topCenter,
                  child: ProfileImage(imageUrl!,
                      placeHolder: AppImages.icon,
                      isFood: true,
                      height: 160,
                      width: 160,
                      borderWidth: 5,
                      borderColor: Theme.of(context).primaryColor,
                      radius: 80))
            ],
          )),
    );
  }
}
