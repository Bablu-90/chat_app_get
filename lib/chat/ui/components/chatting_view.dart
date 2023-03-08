import 'package:flutter/material.dart';

class ChattingView extends StatelessWidget {
  final AnimationController animationController;

  const ChattingView({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn)));
    final secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn)));
    final chatFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn)));
    final chatSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0)).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn)));
    final imageFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn)));
    final imageSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(
            CurvedAnimation(
                parent: animationController,
                curve: const Interval(0.6, 0.8, curve: Curves.fastOutSlowIn)));
    return SlideTransition(
      position: firstHalfAnimation,
      child: SlideTransition(
        position: secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hey! Welcome All',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              SlideTransition(
                position: chatFirstHalfAnimation,
                child: SlideTransition(
                  position: chatSecondHalfAnimation,
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 64, right: 64, top: 16, bottom: 16),
                    child: Text(
                      'Relax and Chat',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: imageFirstHalfAnimation,
                child: SlideTransition(
                  position: imageSecondHalfAnimation,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 350, maxHeight: 250),
                    child: Image.asset(
                      "assets/images/chatting.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
