import 'package:appform/infra/db_sqlite.dart';
import 'package:appform/models/user_model.dart';

class UserRepository {
  DbSQLite db;

  UserRepository(this.db);

  Future<List<User>> getUser() async {
    final instance = await DbSQLite().getInstance();
    var userDb = await instance.query('users');
    var users = userDb.map((user) => User.fromDb(user)).toList();
    return users;
  }

  Future<int> saveUser(User user) async {
    final instance = await DbSQLite().getInstance();
    final idUser = await instance.insert('users', user.toDb());
    return idUser;
  }

  Future<bool> updateUser(User user) async {
    final instance = await DbSQLite().getInstance();
    final effects = await instance.update('users', user.toDb(),
        where: 'user_id = ?', whereArgs: [user.id]);
    return effects > 0;
  }

  Future<bool> deleteUser(int id) async {
    final instance = await DbSQLite().getInstance();
    var effects = await instance.delete(
      'users',
      where: 'user_id = ?',
      whereArgs: [id],
    );

    return effects > 0;
  }
}
