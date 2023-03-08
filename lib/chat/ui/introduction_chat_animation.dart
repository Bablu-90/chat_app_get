import 'dart:io';

import 'package:chat_app_get/auth/ui/login_screen.dart';
import 'package:chat_app_get/chat/get_controllers/introduction_chat_animation_controller.dart';
import 'package:chat_app_get/chat/ui/components/center_next_button.dart';
import 'package:chat_app_get/chat/ui/components/chatting_view.dart';
import 'package:chat_app_get/chat/ui/components/communication_view.dart';
import 'package:chat_app_get/chat/ui/components/splash_view.dart';
import 'package:chat_app_get/chat/ui/components/top_back_skip_view.dart';
import 'package:chat_app_get/chat/ui/components/welcome_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class IntroductionChatAnimation extends StatefulWidget {
  const IntroductionChatAnimation({Key? key}) : super(key: key);

  @override
  State<IntroductionChatAnimation> createState() =>
      _IntroductionChatAnimationState();
}

class _IntroductionChatAnimationState extends State<IntroductionChatAnimation> {
  AnimationController? animationController;

  void onSkipClick() {
    animationController?.animateTo(0.8, duration: Duration(milliseconds: 1200));
  }

  void onBackClick() {
    if (animationController!.value >= 0 && animationController!.value <= 0.2) {
      animationController?.animateTo(0.0);
    } else if (animationController!.value > 0.2 &&
        animationController!.value <= 0.4) {
      animationController?.animateTo(0.2);
    } else if (animationController!.value > 0.4 &&
        animationController!.value <= 0.6) {
      animationController?.animateTo(0.4);
    } else if (animationController!.value > 0.6 &&
        animationController!.value <= 0.8) {
      animationController?.animateTo(0.6);
    } else if (animationController!.value > 0.8 &&
        animationController!.value <= 1.0) {
      animationController?.animateTo(0.8);
    }
  }

  void onNextClick() {
    if (animationController!.value >= 0 && animationController!.value <= 0.2) {
      animationController?.animateTo(0.4);
    } else if (animationController!.value > 0.2 &&
        animationController!.value <= 0.4) {
      animationController?.animateTo(0.6);
    } else if (animationController!.value > 0.4 &&
        animationController!.value <= 0.6) {
      animationController?.animateTo(0.8);
    } else if (animationController!.value > 0.6 &&
        animationController!.value <= 0.8) {
      loginClick();
    }
  }

  void loginClick() {
    Get.offAll(() => LoginScreen(userImageFile: File('image')),
        transition: Transition.downToUp);
  }

  @override
  Widget build(BuildContext context) {
    IntroductionChatAnimationController introductionChatAnimationController =
        Get.put(IntroductionChatAnimationController());
    animationController =
        introductionChatAnimationController.animationController;
    return Scaffold(
      backgroundColor: Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: animationController!,
            ),
            CommunicationView(
              animationController: animationController!,
            ),
            ChattingView(
              animationController: animationController!,
            ),
            WelcomeView(
              animationController: animationController!,
            ),
            TopBackSkipView(
              animationController: animationController!,
            ),
            CenterNextButton(
                animationController: animationController!,
                onNextClick: onNextClick)
          ],
        ),
      ),
    );
  }
}
