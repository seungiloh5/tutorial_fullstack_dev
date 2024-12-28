// Model
import 'package:flutter/material.dart';

class CounterModel {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
  }
}

// ViewModel
class CounterViewModel {
  final CounterModel _model = CounterModel();
  ValueNotifier<int> countNotifier = ValueNotifier(0);

  void increment() {
    _model.increment();
    countNotifier.value = _model.count;
  }
}

// View
class CounterView extends StatelessWidget {
  final CounterViewModel viewModel;

  const CounterView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.countNotifier,
      builder: (context, int count, _) {
        return ElevatedButton(
          onPressed: () => viewModel.increment(),
          child: Text(
            '$count',
          ),
        );
      },
    );
  }
}
