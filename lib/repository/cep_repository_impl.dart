import 'dart:convert';

import 'package:appform/models/cep_model.dart';
import 'package:appform/repository/cep_repository.dart';
import 'package:dio/dio.dart';

class CepRetpositoryImpl implements CepRepository {
  @override
  Future<Endereco> getCep(String cep) async {
    final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      return Endereco.fromJson(response.data);
    }
  }
}
