import 'package:appform/models/cep_model.dart';

class User {
  int id;
  String name;
  String email;
  String cpf;
  Endereco endereco;

  User({this.id, this.cpf, this.email, this.name, this.endereco});

  factory User.fromDb(Map<String, dynamic> user) {
    return User(
      id: user['user_id'],
      name: user['name'],
      email: user['email'],
      cpf: user['cpf'],
    );
  }

  Map<String, dynamic> toDb() {
    var userDb = {
      'user_id': this.id,
      'name': this.name,
      'email': this.email,
      'cpf': this.cpf,
    };
    return userDb;
  }

  @override
  String toString() {
    return '$name --- $cpf ----- $email ';
  }
}
