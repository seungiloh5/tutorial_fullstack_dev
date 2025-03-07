import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home.dart';
import 'screens/auth/intro.dart';
import 'screens/auth/register.dart';
// import 'screens/sliver_appbar.dart';

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp(this.isLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFF6f0f),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFFF6f0f),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 18, fontFamily: 'Noto Sans'),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Noto Sans'),
          labelLarge: TextStyle(
              fontSize: 16,
              fontFamily: 'Noto Sans',
              fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFF7E36),
            padding: const EdgeInsets.symmetric(vertical: 22),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xffFF7E36),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          floatingLabelStyle: TextStyle(fontSize: 10),
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Practice',
      initialRoute: isLogin ? '/' : '/intro',
      routes: {
        '/': (context) => const Home(),
        '/intro': (context) => const Intro(),
        '/register': (context) => const Register(),
      },
    );
  }
}
