import 'package:appform/infra/db_sqlite.dart';
import 'package:appform/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:email_validator/email_validator.dart';

import '../../models/user_model.dart';
import '../../service/service.dart';

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  CepRetpositoryImpl cepReopo = CepRetpositoryImpl();
  TextEditingController controllerRua = TextEditingController();
  TextEditingController controllerBairro = TextEditingController();
  TextEditingController controllerCidade = TextEditingController();
  TextEditingController controllerUf = TextEditingController();

  String getCep = '';
  User _user = User();

  GlobalKey<FormState> _form = GlobalKey();

  void saveUser() async {
    _form.currentState.save();

    var repository = UserRepository(DbSQLite());
    if (_user != null) {
      _user.id = await repository.saveUser(_user);
    }

    return Navigator.of(context).pop(_user);
  }

  void validator() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadastrado com sucesso'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Existem campos a serem preenchidos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  onChanged: (value) {
                    _user.name = value;
                  },
                  validator: (value) {
                    return value.isEmpty ? 'Campo Obrigatório' : null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nome completo',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _user.email = value;
                  },
                  validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return 'Esse e-mail não é válido';
                    }
                    return value.isEmpty ? 'Campo Obrigatório' : null;
                  },
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _user.cpf = value;
                  },
                  validator: (value) {
                    if (!CPF.isValid(value)) {
                      return 'Esse cpf não é válido';
                    }
                    return value.isEmpty ? 'Campo Obrigatório' : null;
                  },
                  decoration: InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: width * 0.55,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          getCep = value;
                        },
                        validator: (value) {
                          return value.isEmpty ? 'Campo Obrigatório' : null;
                        },
                        decoration: InputDecoration(
                          labelText: 'CEP',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () async {
                        _user.endereco = await cepReopo.getCep(getCep);
                        setState(
                          () {
                            controllerRua.text = _user.endereco.rua;
                            controllerBairro.text = _user.endereco.bairro;
                            controllerCidade.text = _user.endereco.cidade;
                            controllerUf.text = _user.endereco.uf;
                          },
                        );
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Buscar CEP'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: width * 0.6,
                      child: TextFormField(
                        controller: controllerRua,
                        decoration: InputDecoration(
                          labelText: 'Rua',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: width * 0.29,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return value.isEmpty ? 'Campo Obrigatório' : null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Número',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: width * 0.45,
                      child: TextFormField(
                        controller: controllerBairro,
                        decoration: InputDecoration(
                          labelText: 'Bairro',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: width * 0.44,
                      child: TextFormField(
                        controller: controllerCidade,
                        decoration: InputDecoration(
                          labelText: 'Cidade',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: width * 0.45,
                      child: TextFormField(
                        controller: controllerUf,
                        decoration: InputDecoration(
                          labelText: 'UF',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: width * 0.44,
                      child: TextFormField(
                        onChanged: (value) => print(value),
                        validator: (value) {
                          return value.isEmpty ? 'Campo obrigatório' : null;
                        },
                        decoration: InputDecoration(
                          labelText: 'País',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: width * 0.09,
                  ),
                  width: double.infinity,
                  child: OutlineButton(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text('Cadastrar'),
                    onPressed: () {
                      validator();
                      saveUser();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
