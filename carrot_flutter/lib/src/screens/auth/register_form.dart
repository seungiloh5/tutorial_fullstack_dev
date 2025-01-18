import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../home.dart';
import 'package:carrot_flutter/src/widgets/forms/label_textfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final authController = Get.put(AuthController());
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();

  _submit() async {
    bool result = await authController.register(
      _nameController.text,
      _passwordController.text,
      null,
    );
    if (result) {
      Get.offAll(() => const Home());
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
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 16),
            // 닉네임
            LabelTextField(
              label: '닉네임',
              hintText: '닉네임을 입력해주세요',
              controller: _nameController,
              isObscure: true,
            ),
            // 비밀번호
            LabelTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력해주세요',
              controller: _passwordController,
              isObscure: true,
            ),
            // 비밀번호 확인
            LabelTextField(
              label: '비밀번호 확인',
              hintText: '비밀번호를 다시 입력해주세요',
              controller: _passwordConfirmController,
              isObscure: true,
            ),
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
