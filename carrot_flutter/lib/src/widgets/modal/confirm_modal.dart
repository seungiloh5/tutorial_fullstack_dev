import 'package:flutter/material.dart';

class ConfirmModal extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final VoidCallback cancel;
  final VoidCallback confirmAction;

  const ConfirmModal({
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancel,
    required this.confirmAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: cancel,
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: confirmAction,
          child: Text(confirmText),
        ),
      ],
    );
  }
}
