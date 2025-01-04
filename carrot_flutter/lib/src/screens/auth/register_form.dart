import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../home.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final authController = Get.put(AuthController());
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  _submit() async {
    bool result = await authController.register(
      _nameController.text,
      _passwordController.text,
      null,
    );
    if (result) {
      Get.off(() => const Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원 가입')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // 프로필 이미지
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
            ),
            // 닉네임
            Text('닉네임', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: '닉네임을 입력해주세요',
              ),
            ),
            const SizedBox(height: 16),
            // 비밀번호
            Text('비밀번호', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              style: const TextStyle(fontSize: 16),
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호를 입력해주세요',
              ),
            ),
            const SizedBox(height: 16),
            // 비밀번호 확인
            Text('비밀번호 확인', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: '비밀번호를 다시 입력해주세요',
              ),
            ),
            const SizedBox(height: 16),
            // 버튼
            ElevatedButton(
              onPressed: _submit,
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
