import 'dart:io';

import 'package:chat_app_get/auth/ui/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TopBackSkipView extends StatelessWidget {
  final AnimationController animationController;

  const TopBackSkipView({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final skipAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: animation,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SlideTransition(
                //   position: _backAnimation,
                //   child:
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  //   ),
                ),
                SlideTransition(
                  position: skipAnimation,
                  child: IconButton(
                    onPressed: () {
                      Get.offAll(
                          () => LoginScreen(userImageFile: File('image')),
                          transition: Transition.fadeIn);
                    },
                    icon: const Text('Skip'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
