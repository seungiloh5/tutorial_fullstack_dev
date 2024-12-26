import 'package:flutter/material.dart';
import '../modal/confirm_modal.dart';

class MoreBottomModal extends StatelessWidget {
  final VoidCallback cancelTap;
  final VoidCallback hideTap;

  const MoreBottomModal({
    required this.cancelTap,
    required this.hideTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 첫번째 영역
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    leading: Icon(Icons.visibility_off_outlined),
                    title: Text('이 글 숨기기'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmModal(
                            title: '글 숨기기',
                            content: '이 게시글을 숨기겠습니까?',
                            confirmText: '숨기기',
                            cancel: () {
                              Navigator.pop(context);
                            },
                            confirmAction: () {
                              hideTap();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    }),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('게시글 노출 기준'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.red,
                  ),
                  title: Text('신고하기'),
                ),
              ],
            ),
          ),
          // 두번째 영역
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text('닫기', textAlign: TextAlign.center),
              onTap: cancelTap,
            ),
          ),
        ],
      ),
    );
  }
}
