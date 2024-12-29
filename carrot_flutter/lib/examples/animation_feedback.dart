import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: FeedbackAnimationExample(),
  ));
}

class FeedbackAnimationExample extends StatefulWidget {
  const FeedbackAnimationExample({Key? key}) : super(key: key);

  @override
  State<FeedbackAnimationExample> createState() =>
      _FeedbackAnimationExampleState();
}

class _FeedbackAnimationExampleState extends State<FeedbackAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 1.2).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Material(
          // Material 위젯 추가
          color: Colors.transparent,
          child: InkWell(
            onTap: _onTap,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const Text(
                      'Tap Me',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
