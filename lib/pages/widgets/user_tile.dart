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
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
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
