import 'package:appform/infra/db_sqlite.dart';
import 'package:appform/models/user_model.dart';
import 'package:appform/pages/widgets/form_widget.dart';
import 'package:appform/pages/widgets/user_tile.dart';
import 'package:appform/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class ListUser extends StatefulWidget {
  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<User> users = [];
  User user;
  var repository = UserRepository(DbSQLite());

  @override
  void initState() {
    super.initState();

    repository.getUser().then((value) {
      if (value != null) {
        setState(() {
          users = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(users);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: FutureBuilder<List<User>>(
        initialData: [],
        future: repository.getUser(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              if (!snapshot.hasData && !snapshot.error) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData && snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.hasError.toString(),
                  ),
                );
              }
              return UserTile(
                user: snapshot.data[index],
                onLongPress: () async {
                  var deleted =
                      await repository.deleteUser(snapshot.data[index].id);
                  if (deleted) {
                    setState(() {
                      snapshot.data.removeAt(index);
                    });
                  }
                },
                onDismissed: (direction) async {
                  var deleted =
                      await repository.deleteUser(snapshot.data[index].id);
                  if (deleted) {
                    setState(() {
                      snapshot.data.removeAt(index);
                    });
                  }
                },
                onTap: () async {
                  var upDated =
                      await repository.updateUser(snapshot.data[index]);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          user = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FormWidget();
              },
            ),
          );
          // print(user);
          if (user != null) {
            setState(() {});
          }
          // print(users);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
