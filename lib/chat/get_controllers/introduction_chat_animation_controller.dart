import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class IntroductionChatAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
   AnimationController? animationController;

  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    animationController?.animateTo(0.0);
    super.onInit();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
