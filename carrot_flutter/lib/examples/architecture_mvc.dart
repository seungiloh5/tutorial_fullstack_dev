import 'package:flutter/material.dart';

// Model
class CounterModel {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
  }
}

// Controller
class CounterController {
  final CounterModel model = CounterModel();

  void increment() {
    model.increment();
  }

  int getCount() {
    return model.count;
  }
}

// View
class CounterView extends StatelessWidget {
  final CounterController controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        controller.increment();
        print('${controller.getCount()}');
      },
      child: Text('Increment'),
    );
  }
}
