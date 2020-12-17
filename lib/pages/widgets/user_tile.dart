import 'package:appform/models/user_model.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;
  final Function() onLongPress;
  final Function() onTap;
  final Function(DismissDirection direction) onDismissed;

  const UserTile({this.user, this.onLongPress, this.onTap, this.onDismissed});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(user.name),
      onDismissed: onDismissed,
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(user.name),
        subtitle: Text(user.email),
        onLongPress: onLongPress,
        trailing: GestureDetector(
          onTap: onTap,
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}
