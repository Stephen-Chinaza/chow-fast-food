import 'package:chow/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import 'image_view.dart';

class RatingView extends StatelessWidget {
  final int rating;
  final Function(int)? onSelected;
  final Color color;
  final Color selectedColor;
  final double space;
  final double size;
  const RatingView({required this.rating,
    this.onSelected, this.color=AppColors.yellow,
    this.selectedColor=AppColors.lightBackground,
    this.space=5,
    this.size=18,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(5, (index) => InkWell(
          onTap: (){
            if(onSelected!=null)onSelected!(index);},
          child: Padding(
            padding: EdgeInsets.only(left: _isLast(index)? 0 : space),
            child: ImageView.svg(AppImages.icStar,
            height: size, width: size,
            color:  index+1<=rating
                ? color : selectedColor),
          )
        ))
    );
  }

  bool _isLast(int index) {
    return index==5;
  }

}
