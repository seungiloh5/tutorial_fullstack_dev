import 'package:flutter/material.dart';

final List<Tab> myTabs = <Tab>[
  Tab(icon: Icon(Icons.home), text: '홈'),
  Tab(icon: Icon(Icons.feed), text: '동네'),
  Tab(icon: Icon(Icons.chat_bubble_outline_rounded), text: '채팅'),
  Tab(icon: Icon(Icons.person_outline), text: '마이'),
];

final List<Widget> myTabItems = [
  Center(child: Text('홈')),
  Center(child: Text('동네')),
  Center(child: Text('채팅')),
  Center(child: Text('마이')),
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('내 동네'),
          bottom: TabBar(tabs: myTabs),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        body: TabBarView(
          children: myTabItems,
        ),
      ),
    );
  }
}
