import 'package:flutter/material.dart';
import 'dart:async';

// BLoC
class CounterBloc {
  int _count = 0;
  final _countController = StreamController<int>();

  Stream<int> get countStream => _countController.stream; // 외부 노출

  void increment() {
    _count++;
    _countController.sink
        .add(_count); // 데이터가 스트림으로 들어가는 입구 역할 (sink) + 데이터를 넣는 역할 (add)
  }

  void dispose() {
    _countController.close();
  }
}

class CounterView extends StatelessWidget {
  final CounterBloc bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: bloc.countStream, // BLoC의 Stream을 연결
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0; // 최신 데이터 반영
        return ElevatedButton(
          onPressed: () {
            bloc.increment();
          },
          child: Text('Increment ($count)'),
        );
      },
    );
  }
}
