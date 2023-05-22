import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:appinio_swiper/appinio_swiper.dart';

class TinderButtons extends StatelessWidget {
  final Function onTap;
  final Widget child;

  const TinderButtons({
    required this.onTap,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: child,
    );
  }
}

//swipe card to the right side
Widget swipeRightButton(AppinioSwiperController controller) {
  return TinderButtons(
    onTap: () => controller.swipeRight(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 35, 35, 1),
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.check,
        color: Color.fromRGBO(0, 180, 0, 1),
        size: 50,
      ),
    ),
  );
}

//swipe card to the left side
Widget swipeLeftButton(AppinioSwiperController controller) {
  return TinderButtons(
    onTap: () => controller.swipeLeft(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 35, 35, 1),
        borderRadius: BorderRadius.circular(50),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.close,
        color: Color.fromRGBO(180, 0, 0, 1),
        size: 50,
      ),
    ),
  );
}

//unswipe card
Widget unswipeButton(AppinioSwiperController controller) {
  return TinderButtons(
    onTap: () => controller.unswipe(),
    child: Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      child: const Icon(
        Icons.rotate_left_rounded,
        color: Color.fromRGBO(150, 150, 150, 1),
        size: 40,
      ),
    ),
  );
}