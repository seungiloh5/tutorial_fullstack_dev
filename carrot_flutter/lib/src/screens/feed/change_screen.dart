import 'package:flutter/material.dart';

import '../feed/show.dart';
import '../auth/intro.dart';
import '../auth/register.dart';
import '../unknown.dart';
import '../shared/data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carrot Market',
      routes: {
        '/': (context) => const Intro(),
        '/register': (context) => const Register(),
      },
      initialRoute: '/',
      onGenerateRoute: (route) {
        if (route.name!.startsWith('/feed/')) {
          print(route.name);
          final id = int.parse(route.name!.split('/').last);
          final item = feedList.firstWhere((e) => e['id'] == id);
          print(item);
          return MaterialPageRoute(
            builder: (context) => FeedShow(1),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const UnknownScreen(),
        );
      },
    );
  }
}
