import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: CurvedScreen(),
  ));
}

class CurvedScreen extends StatefulWidget {
  const CurvedScreen({super.key});

  @override
  State<CurvedScreen> createState() => _CurvedScreenState();
}

class _CurvedScreenState extends State<CurvedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
