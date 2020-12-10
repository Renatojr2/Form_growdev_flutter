import 'package:cpfcnpj/cpfcnpj.dart';

import 'package:appform/models/cep_model.dart';
import 'package:appform/models/user_model.dart';
import 'package:appform/repository/cep_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class FormWidget extends StatefulWidget {
  final GlobalKey<FormState> _form;

  FormWidget(this._form);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final CepRetpositoryImpl cepReopo = CepRetpositoryImpl();
  TextEditingController controllerRua = TextEditingController();
  TextEditingController controllerBairro = TextEditingController();
  TextEditingController controllerCidade = TextEditingController();
  TextEditingController controllerUf = TextEditingController();

  String getCep = '';

  final User user = User();

  final Endereco cep = Endereco();
  var response;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Form(
      key: widget._form,
      child: Column(
        children: [
          TextFormField(
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
                  response = await cepReopo.getCep(getCep);
                  setState(() {
                    controllerRua.text = response.rua;
                    controllerBairro.text = response.bairro;
                    controllerCidade.text = response.cidade;
                    controllerUf.text = response.uf;
                  });
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
              ),
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
        ],
      ),
    );
  }
}
