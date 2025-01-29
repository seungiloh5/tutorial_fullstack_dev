import 'package:flutter/material.dart';
import '../../models/user_model.dart';

class UserListItem extends StatelessWidget {
  final UserModel user;
  const UserListItem(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: user.profileUrl != null
                ? NetworkImage(user.profileUrl)
                : AssetImage('assets/images/no_image.png'),
          ),
          const SizedBox(width: 10),
          Text(user.name),
        ],
      ),
    );
  }
}
