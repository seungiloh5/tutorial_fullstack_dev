import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MaterialApp(
    home: Intro(),
  ));
}

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 로고
                    Image.asset('assets/images/logo.png',
                        width: 300, height: 300),
                    // 슬로건
                    const SizedBox(height: 20),
                    const Text(
                      '당신의 애견 친구 만들기',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '동네라서 가능한 모든 것 \n지금 내 동네를 선택하고 시작해보세요!',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 회원가입
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const Register());
                  },
                  child: const Text('시작하기'),
                ),
                // 로그인
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('이미 계정이 있으신가요?'),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const Login());
                      },
                      child: const Text('로그인'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
